#!/usr/bin/env bash
set -euo pipefail

PLR_DIR="$HOME/printer_data/gcodes/plr"

# Safety guard: never delete an empty, root or unexpectedly broad path.
if [[ -z "$PLR_DIR" || "$PLR_DIR" == "/" || "$PLR_DIR" != "$HOME"/printer_data/gcodes/plr ]]; then
  echo "PLR: unsicherer Zielpfad, Abbruch: $PLR_DIR" >&2
  exit 1
fi

rm -rf "$PLR_DIR"
mkdir -p "$PLR_DIR"
echo "PLR: Ordner bereinigt: $PLR_DIR"
