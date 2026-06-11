#!/usr/bin/env bash
set -euo pipefail

# usage: macro_beep.sh [BEEPCOUNT] [BEEPDURATION] [PAUSEDURATION]
GPIO_PATH="/sys/class/gpio/gpio82/value"
BEEPCOUNT="${1:-3}"
BEEPDURATION="${2:-0.10}"
PAUSEDURATION="${3:-0.50}"

case "$BEEPCOUNT" in
  ''|*[!0-9]*) BEEPCOUNT=3 ;;
esac

if [ "$BEEPCOUNT" -lt 1 ]; then BEEPCOUNT=1; fi
if [ "$BEEPCOUNT" -gt 10 ]; then BEEPCOUNT=10; fi

if [ ! -w "$GPIO_PATH" ]; then
  echo "GPIO path not writable: $GPIO_PATH" >&2
  exit 1
fi

play_beep() {
  printf '1' > "$GPIO_PATH"
  sleep "$BEEPDURATION"
  printf '0' > "$GPIO_PATH"
}

count=0
while [ "$count" -lt "$BEEPCOUNT" ]; do
  play_beep
  count=$((count + 1))
  if [ "$count" -lt "$BEEPCOUNT" ]; then
    sleep "$PAUSEDURATION"
  fi
done
