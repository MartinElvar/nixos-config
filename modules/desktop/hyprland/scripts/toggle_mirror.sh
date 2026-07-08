#!/usr/bin/env bash
set -euo pipefail

# name of your laptop panel
LAPTOP="eDP-1"

# externals = every connected monitor except the laptop panel
# (monitors all: mirrored monitors are hidden from plain `hyprctl monitors`)
externals=$(hyprctl monitors all -j | jq -r ".[] | select(.name != \"$LAPTOP\") | .name")

if [[ -z "$externals" ]]; then
  hyprctl notify -1 3000 "rgb(ff9900)" "hypr-mirror: no external monitor connected"
  exit 0
fi

if hyprctl monitors all -j | jq -e ".[] | select(.mirrorOf == \"$LAPTOP\")" > /dev/null; then
  # already mirroring → switch back to extend
  for m in $externals; do
    hyprctl keyword monitor "$m,preferred,auto,1"
  done
  hyprctl notify -1 3000 "rgb(00ff99)" "hypr-mirror: extending"
else
  # not mirroring → mirror all externals to laptop
  for m in $externals; do
    hyprctl keyword monitor "$m,preferred,auto,1,mirror,$LAPTOP"
  done
  hyprctl notify -1 3000 "rgb(00ff99)" "hypr-mirror: mirroring $LAPTOP"
fi
