#!/bin/bash
set -euo pipefail

PLR_DIR="$HOME/printer_data/gcodes/plr"

if [ -d "$PLR_DIR" ]; then
  rm -rf "$PLR_DIR"
fi

mkdir -p "$PLR_DIR"
echo "PLR: Ordner bereinigt: $PLR_DIR"
