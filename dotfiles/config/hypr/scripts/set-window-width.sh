#!/bin/bash

# Set the focused window's width to monitor_width / ratio (default 2), keeping
# its current height.
#
# Why this isn't a one-liner: `hyprctl dispatch resizeactive exact` is
# anchor-dependent in the dwindle layout. For a window that is the *second*
# child of its split, the size delta is applied with a flipped sign, so the
# window lands on `2*current - requested` instead of `requested`. Which case
# applies depends on the window's position in the (nested) split tree, which
# cannot be reconstructed from window geometry alone.
#
# Point-of-view change: instead of predicting the anchor, run a closed loop --
# dispatch, measure the real result, and issue a single corrective dispatch
# only when we can confirm the delta was flipped (rather than the window
# hitting a genuine size constraint).

ratio=${1:-2}
tolerance=10   # px; gaps/rounding leave exact sizes off by a pixel or two

monitor_width=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .width')
target=$((monitor_width / ratio))

geom() { hyprctl activewindow -j | jq -r "$1"; }

# absolute difference helper
abs() { local n=$1; ((n < 0)) && n=$((-n)); echo "$n"; }

height=$(geom '.size[1]')
before=$(geom '.size[0]')

# First attempt: ask for the target directly (correct for "normal" windows).
hyprctl dispatch resizeactive exact "$target $height"
result=$(geom '.size[0]')

# Already on target -> done.
if (( $(abs $((result - target))) <= tolerance )); then
    exit 0
fi

# Only correct if the miss matches the flipped-delta signature
# (result == 2*before - target). Otherwise the window hit a real size
# constraint (e.g. a tiny sibling subtree) and we leave it as best effort
# rather than fight it.
flip=$((2 * before - target))
if (( $(abs $((result - flip))) <= tolerance )); then
    hyprctl dispatch resizeactive exact "$((2 * result - target)) $height"
fi
