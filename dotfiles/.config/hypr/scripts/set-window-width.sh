!/bin/bash

# Default ratio is 2 unless user provides one
ratio=${1:-2}

# Get the name of the focused monitor
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')

# Get the width of the focused monitor
monitor_width=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$focused_monitor\") | .width")

# Calculate target width for the window
target_width=$((monitor_width / ratio))

# Resize the active window to target_width while keeping current height
# We need the current height of the active window
active_window_height=$(hyprctl activewindow -j | jq -r ".size[1]")

# Dispatch resize
hyprctl dispatch resizeactive exact "$target_width $active_window_height"
