#!/usr/bin/env bash

read -r gpu mem_used mem_total < <(nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total --format=csv,noheader 2>/dev/null | tr -d ' %MiB' | tr ',' ' ')

mem_gb=$(awk "BEGIN {printf \"%.1f\", $mem_used / 1024}")

printf '{"text": "%s%% %sG", "tooltip": "GPU: %s%%  VRAM: %s / %s MiB"}' "$gpu" "$mem_gb" "$gpu" "$mem_used" "$mem_total"
