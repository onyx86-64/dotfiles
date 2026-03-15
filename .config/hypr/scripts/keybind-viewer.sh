#!/bin/bash

bindings=$(hyprctl binds -j | jq -r '
  .[]
  | select(.dispatcher != "")
  | "\(.key)\tdispatcher:\(.dispatcher)\targ:\(.arg)"
')

[ -z "$bindings" ] && { echo "No keybindings found."; exit 1; }

formatted=$(echo "$bindings" | column -t -s $'\t')

selected=$(echo "$formatted" | fuzzel --dmenu --prompt "Select a keybind:")

if [ -z "$selected" ]; then
  echo "No selection."
  exit 0
fi

dispatcher=$(echo "$selected" | awk '{print $2}' | cut -d: -f2)
arg=$(echo "$selected" | sed -n 's/.*arg:\s*\(.*\)/\1/p')


if [ "$dispatcher" = "exec" ]; then
  if [ -n "$arg" ]; then
    hyprctl dispatch exec -- "$arg"
  else
    echo "Warning: 'exec' with empty arg; nothing to run."
  fi
else
  # Always include arg, empty or not
  hyprctl dispatch "$dispatcher" "${arg:-""}"
fi
