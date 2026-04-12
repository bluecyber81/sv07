# Repo-Audit (2026-04-12)

## Kurzfazit
Das Repository ist für einen produktiven SV07-Backupstand grundsätzlich brauchbar. Haupthebel für bessere Wartbarkeit sind konsistente Dateinamen, weniger Altlasten im Live-Pfad und ein reproduzierbarer Export-Workflow.

## Geprüft
- Struktureller Einstieg (`README.md`, `docs/`)
- aktive Klipper-Konfiguration (`printer_data/config/printer.cfg` + Includes)
- Hilfsskripte in `printer_data/config/macro/`
- offensichtliche Altlasten/duplizierte Konfigurationsdateien

## Feststellungen
1. **Obsolete Alternativdatei mit uneinheitlichem Namen**
   - `printer_data/config/alt autotune_tmc.cfg` war eine ältere/alternative Variante.
   - Problem: uneinheitlicher Dateiname mit Leerzeichen und potenziell verwirrend gegenüber `autotune_tmc.cfg`.

2. **Kein standardisierter ZIP-Export für Web-Upload**
   - Für „manuell auf GitHub hochladen“ fehlte ein reproduzierbarer Exportprozess.

## Umgesetzte Verbesserungen
- Obsolete Datei `printer_data/config/alt autotune_tmc.cfg` entfernt.
- Skript `scripts/create_github_upload_zip.sh` hinzugefügt (erzeugt bereinigtes ZIP ohne `.git`).
- Anleitung `docs/MANUAL_GITHUB_UPLOAD.md` ergänzt.
- `README.md` um schnellen Verweis auf den ZIP-Workflow erweitert.

## Empfohlene nächste Schritte (optional)
- Vor jeder Änderung am Drucker `printer.cfg` + `saved_variables.cfg` lokal sichern.
- Größere Makroänderungen in separaten Commits halten (Rollback einfacher).
- Bei Hardware-Tuning (`autotune_tmc.cfg`) Werte mit Datum/Kommentar dokumentieren.
