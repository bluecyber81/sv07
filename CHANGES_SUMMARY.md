# Aenderungsuebersicht

## Gegenueber dem aktuellen GitHub-Repo

- Neue Konfig aus `config-20260608.zip` uebernommen.
- `plr.sh` und `clear_plr.sh` als mitgelieferte PLR-Skripte ergaenzt.
- `printer_additions/kpa_leds_sv07plus_module.cfg` ergaenzt.
- `alt autotune_tmc.cfg` aus dem bereinigten Paket entfernt, weil es nicht im neuen Export enthalten ist.
- Logs und `.deb`-Pakete bewusst nicht uebernommen.

## Repo-Hygiene

- `.gitattributes` ergaenzt, damit `.cfg`, `.conf`, `.sh` und Markdown-Dateien mit LF-Zeilenenden im Repo landen.
- `.gitignore` um explizite Logmuster unter `printer_data/config/` erweitert.
- README an den aktuellen Include-Stand angepasst.
- `docs/APPLY_CHANGES.md` und `docs/REPO_REVIEW.md` aktualisiert.

## Funktionale Kleinverbesserung

- `shell_command.cfg` ruft PLR-Skripte jetzt aus dem mitgelieferten Config-Ordner auf:
  - `/home/mks/printer_data/config/clear_plr.sh`
  - `/home/mks/printer_data/config/plr.sh`

Die Drucker-Tuningwerte wurden nicht absichtlich veraendert.
