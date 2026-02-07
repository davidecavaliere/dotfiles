#!/usr/bin/env bash

# Toggle ashell on/off

if pgrep -x "ashell" > /dev/null; then
    pkill ashell
    notify-send "Ashell" "Status bar stopped"
else
    ashell &
    notify-send "Ashell" "Status bar started"
fi
