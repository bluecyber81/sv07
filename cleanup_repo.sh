#!/usr/bin/env bash
set -euo pipefail

mkdir -p printer_data/config/archive/old-configs
mkdir -p printer_data/config/archive/generated-backups

# Move old config experiments
for f in   "printer_data/config/alt autotune_tmc.cfg"   "printer_data/config/alte sv7printer.cfg"   "printer_data/config/fix alt printer.cfg"   "printer_data/config/one bttprinter.cfg"   "printer_data/config/printerneu"   printer_data/config/printer-*.cfg   printer_data/config/crowsnest.conf.2025-02-12-1056   printer_data/config/moonraker.conf.backup
  do
  [ -e "$f" ] || continue
  mv "$f" printer_data/config/archive/old-configs/
done

# Remove generated archives and package files from git tracking
if compgen -G 'printer_data/config/config-*.zip' > /dev/null; then
  git rm --cached printer_data/config/config-*.zip || true
fi
if compgen -G 'printer_data/config/macro/*.deb' > /dev/null; then
  git rm --cached printer_data/config/macro/*.deb || true
fi

# Remove duplicate root-level beep scripts if macro/macro_beep.sh is the canonical file
for f in printer_data/config/macro-beep.sh printer_data/config/macro_beep.sh; do
  [ -e "$f" ] || continue
  git rm --cached "$f" || true
  rm -f "$f"
done

git add README.md .gitignore printer_data/config

echo 'Cleanup vorbereitet. Bitte git status prüfen.'
