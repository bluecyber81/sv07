#!/usr/bin/env bash
set -euo pipefail

# Usage: macro_beep.sh [BEEPCOUNT] [BEEPDURATION] [PAUSEDURATION]
# Example: macro_beep.sh 3 0.10 0.50
# GPIO82 is the SV07/Klipad buzzer output used by this setup.

GPIO_PATH="/sys/class/gpio/gpio82/value"

beep_count="${1:-3}"
beep_duration="${2:-0.10}"
pause_duration="${3:-0.50}"

is_positive_int() {
  [[ "$1" =~ ^[0-9]+$ ]] && (( 10#$1 > 0 ))
}

is_duration() {
  [[ "$1" =~ ^([0-9]+)(\.[0-9]+)?$ ]]
}

if ! is_positive_int "$beep_count"; then
  echo "Invalid beep count: $beep_count" >&2
  exit 1
fi

if ! is_duration "$beep_duration"; then
  echo "Invalid beep duration: $beep_duration" >&2
  exit 1
fi

if ! is_duration "$pause_duration"; then
  echo "Invalid pause duration: $pause_duration" >&2
  exit 1
fi

if [[ ! -e "$GPIO_PATH" ]]; then
  echo "GPIO path does not exist: $GPIO_PATH" >&2
  exit 1
fi

if [[ ! -w "$GPIO_PATH" ]]; then
  echo "GPIO path not writable: $GPIO_PATH" >&2
  exit 1
fi

beep_off() {
  printf '0' > "$GPIO_PATH"
}

trap beep_off EXIT

play_beep() {
  printf '1' > "$GPIO_PATH"
  sleep "$beep_duration"
  beep_off
}

for ((i=0; i<beep_count; i++)); do
  play_beep
  if (( i + 1 < beep_count )); then
    sleep "$pause_duration"
  fi
done
