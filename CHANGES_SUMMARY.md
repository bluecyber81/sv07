# Änderungsübersicht

## Stand 2026-04-12

### Repository-Hygiene
- `.gitignore` ergänzt, um Backups, `.deb`-Pakete und temporäre Dateien konsequent aus Git herauszuhalten.
- Veraltete Dateien aus `printer_data/config/macro/` entfernt (`1macro_beep.sh`, `automoun.deb`, `plr-klipper.deb`).

### Drucker-Makros / Hilfsskripte
- `macro/macro_beep.sh` als einzige aktive Beep-Datei konsolidiert.
- Eingabevalidierung im Beep-Skript verbessert:
  - `BEEPCOUNT` wird auf `1..10` begrenzt.
  - Ungültige Dauerwerte werden auf sichere Defaults zurückgesetzt.
- Skript als ausführbar markiert (`chmod +x`).

## Ziel der Änderungen
Fokus auf Wartbarkeit und reproduzierbare Git-Historie: nur relevante Live-Konfigurationen versionieren, Altlasten aus dem aktiven Pfad entfernen und Hilfsskripte robuster machen.
