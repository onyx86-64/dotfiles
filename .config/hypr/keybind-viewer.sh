#!/bin/bash

# Extract keybindings and their associated commands
bindings=$(hyprctl binds -j | jq -r '.[] | select(.dispatcher == "exec") | "\(.key)\t\(.arg)"')

# Check if any bindings were found
if [ -z "$bindings" ]; then
    echo "No 'exec' commands found in keybindings."
    exit 1
fi

# Format the bindings into aligned columns
formatted_bindings=$(echo "$bindings" | column -t -s $'\t')

# Present bindings using Fuzzel in --dmenu mode
selected_binding=$(echo "$formatted_bindings" | fuzzel --dmenu --prompt "Select a command to execute:")

# Execute the selected command if any
if [ -n "$selected_binding" ]; then
    # Extract the command part after the first space(s)
    # Because column replaced tabs with spaces, we can cut by whitespace with awk
    command=$(echo "$selected_binding" | awk '{$1=""; sub(/^ +/, ""); print}')
    eval "$command"
else
    echo "No command selected."
fi
