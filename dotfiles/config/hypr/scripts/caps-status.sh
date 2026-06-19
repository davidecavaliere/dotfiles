#!/usr/bin/env bash

# Prints a hyprpanel module payload only when Caps Lock is ON; otherwise exits
# with no output so the module is hidden (hideOnEmpty). Reads the kernel LED
# state, OR-ing across every capslock LED (one per physical keyboard).

for led in /sys/class/leds/*capslock*/brightness; do
  [[ -r "$led" ]] || continue
  if [[ "$(cat "$led")" != "0" ]]; then
    printf '{"text": "CAPS", "tooltip": "Caps Lock is ON"}'
    exit 0
  fi
done

# Caps Lock off -> empty output, module hidden.
exit 0
