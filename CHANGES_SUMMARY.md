# Änderungsübersicht

## Repo-Struktur
- README vollständig ersetzt
- `.gitignore` erweitert
- `archive/` als Ziel für Altstände vorgesehen
- `cleanup_repo.sh` ergänzt

## Drucker-Konfiguration
- `printer.cfg` formatiert und Makros bereinigt
- `END_PRINT`, `START_PRINT`, `PAUSE`, `RESUME`, `CANCEL_PRINT` robuster gemacht
- doppelte `beep`-Shell-Definition aus `printer.cfg` entfernt

## PLR / Shell
- `plr.cfg` auf reine PLR-Makros reduziert
- doppelte Shell-Commands aus `plr.cfg` entfernt
- `shell_command.cfg` als zentrale Stelle für Shell-Commands ausgebaut

## Sonstiges
- `moonraker.conf` formatiert, aber `channel: dev` unverändert gelassen
- `crowsnest.conf` bereinigt, aktive Werte beibehalten
- `macro/macro_beep.sh` robuster gemacht
- `timelapse.cfg` unverändert übernommen
