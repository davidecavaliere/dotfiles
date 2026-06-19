#!/usr/bin/env bash

output=$(/usr/bin/ollama ps 2>/dev/null)
count=$(echo "$output" | tail -n +2 | grep -c .)

if [[ "$count" -eq 0 ]]; then
  exit 0
fi

readarray -t lines < <(echo "$output" | tail -n +2)

names=()
for line in "${lines[@]}"; do
  name=$(awk '{print $1}' <<< "$line")
  names+=("$name")
done

text="${names[0]}"
if [[ ${#names[@]} -gt 1 ]]; then
  text="${names[0]} +$(( ${#names[@]} - 1 ))"
fi

tooltip=$(echo "$output" | tr '\n' ' ')

printf '{"text": "%s", "tooltip": "%s"}' "$text" "$tooltip"
