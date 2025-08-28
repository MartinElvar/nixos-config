#!/usr/bin/env bash

# name of your laptop panel
LAPTOP="eDP-1"

# check if any monitor is currently mirroring
if hyprctl monitors -j | jq -e ".[] | select(.mirrorOf == \"$LAPTOP\")" > /dev/null; then
  # already mirroring → switch back to extend
  hyprctl dispatch keyword monitor ",preferred,auto,1"
else
  # not mirroring → mirror all externals to laptop
  hyprctl dispatch keyword monitor ",preferred,auto,1,mirror,$LAPTOP"
fi

