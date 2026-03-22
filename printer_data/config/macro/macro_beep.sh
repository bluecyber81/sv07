#!/usr/bin/env bash
set -euo pipefail

# usage: macro_beep.sh [BEEPCOUNT] [BEEPDURATION] [PAUSEDURATION]
# example: macro_beep.sh 3 0.10 0.50

GPIO_PATH="/sys/class/gpio/gpio82/value"

beep_count="${1:-3}"
beep_duration="${2:-0.10}"
pause_duration="${3:-0.50}"

# Basic validation to avoid accidental garbage input from macros.
case "$beep_count" in
  ''|*[!0-9]*)
    echo "Invalid beep count: $beep_count" >&2
    exit 1
    ;;
esac

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
