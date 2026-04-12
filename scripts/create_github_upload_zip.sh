#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATE_TAG="$(date -u +%Y-%m-%d)"
OUT_DIR="$ROOT_DIR/release"
OUT_FILE="$OUT_DIR/sv07-github-upload-${DATE_TAG}.zip"

mkdir -p "$OUT_DIR"
rm -f "$OUT_FILE"

cd "$ROOT_DIR"
zip -r "$OUT_FILE" . \
  -x ".git/*" \
  -x ".github/*" \
  -x "release/*.zip" \
  -x "*.DS_Store" \
  -x "*/__pycache__/*"

echo "ZIP erstellt: $OUT_FILE"
