#!/usr/bin/env bash
set -euo pipefail

get_default_sink() {
    pactl info 2>/dev/null | awk -F": " '/Default Sink/ {print $2}'
}

user_sink="${1:-}"

while true; do
    sink="${user_sink:-$(get_default_sink)}"
    if [[ -z "$sink" ]]; then
        sleep 1
        continue
    fi

    volume_line=$(pactl get-sink-volume "$sink" 2>/dev/null | head -n 1)
    mute_line=$(pactl get-sink-mute "$sink" 2>/dev/null)

    if [[ -z "$volume_line" || -z "$mute_line" ]]; then
        sleep 1
        continue
    fi

    volume_percent=$(echo "$volume_line" | grep -oP '[0-9]+%' | head -n 1 | tr -d '%')
    volume_percent=${volume_percent:-0}

    mute_state=$(echo "$mute_line" | awk '{print $2}')

    if [[ "$mute_state" == "yes" ]]; then
        text="Muted"
        alt="muted"
    else
        text="Vol ${volume_percent}%"
        if (( volume_percent < 30 )); then
            alt="low"
        elif (( volume_percent < 70 )); then
            alt="medium"
        else
            alt="high"
        fi
    fi

    printf '{"text":"%s","alt":"%s"}\n' "$text" "$alt"
    sleep 0.1
done
