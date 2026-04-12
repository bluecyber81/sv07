#!/usr/bin/env bash
set -euo pipefail

# usage: macro_beep.sh [BEEPCOUNT] [BEEPDURATION] [PAUSEDURATION]
# example: macro_beep.sh 3 0.10 0.50

GPIO_PATH="/sys/class/gpio/gpio82/value"

beep_count="${1:-3}"
beep_duration="${2:-0.10}"
pause_duration="${3:-0.50}"

is_number() {
  [[ "$1" =~ ^[0-9]+([.][0-9]+)?$ ]]
}

if ! [[ "$beep_count" =~ ^[0-9]+$ ]]; then
  beep_count=3
fi

if (( beep_count < 1 )); then beep_count=1; fi
if (( beep_count > 10 )); then beep_count=10; fi

if ! is_number "$beep_duration"; then
  beep_duration="0.10"
fi

if ! is_number "$pause_duration"; then
  pause_duration="0.50"
fi

if [[ ! -w "$GPIO_PATH" ]]; then
  echo "GPIO path not writable: $GPIO_PATH" >&2
  exit 1
fi

play_beep() {
  printf '1' > "$GPIO_PATH"
  sleep "$beep_duration"
  printf '0' > "$GPIO_PATH"
}

for ((i=0; i<beep_count; i++)); do
  play_beep
  if (( i + 1 < beep_count )); then
    sleep "$pause_duration"
  fi
done
