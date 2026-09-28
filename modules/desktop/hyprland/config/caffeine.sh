# caffeine — keep the system awake, like Caffeine/Amphetamine on macOS.
#
# While active, a transient systemd user unit holds a logind inhibitor lock
# for "idle:sleep". hypridle honours idle inhibitors (so no lockscreen / dpms
# off) and logind refuses idle suspend.

UNIT="caffeine"
SIGNAL="${CAFFEINE_SIGNAL:-8}"
STATE="${XDG_RUNTIME_DIR:-/tmp}/caffeine.until"
SELF="$(readlink -f "$0")"

usage() {
  cat <<EOF
Usage: caffeine <command>

  on [DURATION]   Keep awake, optionally for DURATION (e.g. 30m, 1h, 90s)
  off             Allow idle lock/sleep again
  toggle          Switch between on (indefinitely) and off
  menu            Pick a duration with wofi
  status          Print waybar JSON
  is-active       Exit 0 if active
EOF
}

is_active() {
  systemctl --user is-active --quiet "$UNIT.service"
}

refresh_waybar() {
  pkill -RTMIN+"$SIGNAL" waybar 2>/dev/null || true
}

to_seconds() {
  local d="$1"
  if [[ "$d" =~ ^([0-9]+)([smh]?)$ ]]; then
    local n="${BASH_REMATCH[1]}"
    case "${BASH_REMATCH[2]}" in
      h) echo $((n * 3600)) ;;
      m | "") echo $((n * 60)) ;;
      s) echo "$n" ;;
    esac
  else
    echo "caffeine: invalid duration '$d' (use e.g. 30m, 2h, 45s)" >&2
    exit 2
  fi
}

stop() {
  if is_active; then
    systemctl --user stop "$UNIT.service"
  fi
  rm -f "$STATE"
  refresh_waybar
}

start() {
  local seconds="" duration="infinity"
  if [[ -n "${1:-}" ]]; then
    seconds="$(to_seconds "$1")"
    duration="$seconds"
  fi

  is_active && systemctl --user stop "$UNIT.service"
  systemctl --user reset-failed "$UNIT.service" 2>/dev/null || true

  if [[ -n "$seconds" ]]; then
    echo $(($(date +%s) + seconds)) >"$STATE"
  else
    rm -f "$STATE"
  fi

  systemd-run --user --quiet --collect \
    --unit="$UNIT" \
    --description="Caffeine: keeping the system awake" \
    -p ExecStopPost="$SELF _stopped" \
    systemd-inhibit \
    --what=idle:sleep \
    --who=Caffeine \
    --why="Caffeine is keeping the system awake" \
    --mode=block \
    sleep "$duration"

  refresh_waybar
}

fmt_remaining() {
  local s="$1" h m
  h=$((s / 3600))
  m=$(((s % 3600 + 59) / 60))
  if ((m == 60)); then h=$((h + 1)); m=0; fi
  if ((h > 0)); then
    printf '%dh %02dm' "$h" "$m"
  else
    printf '%d min' "$m"
  fi
}

status() {
  if is_active; then
    local tooltip="Caffeine: On"
    if [[ -f "$STATE" ]]; then
      local until now
      until="$(<"$STATE")"
      now="$(date +%s)"
      tooltip+="\\nUntil $(date -d "@$until" +%H:%M) ($(fmt_remaining $((until - now))) left)"
    else
      tooltip+="\\nKeeping awake indefinitely"
    fi
    tooltip+="\\n\\nClick to turn off · Right-click for options"
    printf '{"text":"","alt":"active","class":"active","tooltip":"%s"}\n' "$tooltip"
  else
    printf '{"text":"","alt":"inactive","class":"inactive","tooltip":"%s"}\n' \
      "Caffeine: Off\\nSystem will lock and sleep when idle\\n\\nClick to keep awake · Right-click for options"
  fi
}

menu() {
  local options choice
  options="Indefinitely
5 minutes
10 minutes
15 minutes
30 minutes
1 hour
2 hours
5 hours"
  is_active && options+=$'\nTurn off'

  choice="$(wofi --dmenu --insensitive --prompt "Keep awake…" \
    --lines 10 --width 260 <<<"$options")" || exit 0

  case "$choice" in
    "Indefinitely") start ;;
    "Turn off") stop ;;
    *" minutes") start "${choice%% *}m" ;;
    *" hour" | *" hours") start "${choice%% *}h" ;;
  esac
}

case "${1:-}" in
  on) start "${2:-}" ;;
  off) stop ;;
  toggle) if is_active; then stop; else start; fi ;;
  menu) menu ;;
  status) status ;;
  is-active) is_active ;;
  _stopped) rm -f "$STATE"; refresh_waybar ;; # ExecStopPost hook
  -h | --help | help) usage ;;
  *) usage >&2; exit 2 ;;
esac
