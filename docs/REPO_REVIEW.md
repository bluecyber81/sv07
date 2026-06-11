# Repo-Analyse fuer `bluecyber81/sv07`

Stand der Analyse: 2026-06-11

## Ergebnis

Das GitHub-Repo `bluecyber81/sv07` ist das passende Ziel fuer die neue `config-20260608.zip`. Das Repo ist bereits deutlich sauberer als ein roher Druckerexport: Es enthaelt README, `.gitignore`, Doku und keine grossen Logdateien.

## Gute Punkte

- Repo-Struktur liegt im erwarteten Pfad `printer_data/config/`.
- `printer.cfg` ist der klare Einstiegspunkt.
- KPA-Module sind unter `printer_additions/` getrennt.
- `.gitignore` filtert ZIPs, Logs, `.deb`-Pakete und Runtime-Daten.
- Das letzte GitHub-Commit war `401715e Improve README for current SV07 config state`.

## Neue ZIP gegen GitHub

Die neue ZIP bringt relevante neue Dateien mit:

- `printer_data/config/plr.sh`
- `printer_data/config/clear_plr.sh`
- `printer_data/config/printer_additions/kpa_leds_sv07plus_module.cfg`

Die ZIP enthielt ausserdem Dateien, die nicht auf GitHub gehoeren und deshalb im bereinigten Paket fehlen:

- `crowsnest.log`
- `klippy.log`
- `moonraker (4).log`
- `.deb`-Pakete im `macro/`-Ordner

## Technische Befunde

- Die aktive Include-Kette ab `printer.cfg` wurde geprueft: keine fehlenden Includes.
- Die Logs zeigen zuletzt `Klippy ready`, also keine offensichtliche Startblockade im Export.
- `moonraker (4).log` enthaelt lokale IPs und Systemdetails; gut, dass Logs nicht hochgeladen werden.
- `crowsnest.log` enthaelt historische Kamera-Fehler wie `No usable Devices Found`; das ist ein Betriebslog, kein Repo-Inhalt.
- Die neue ZIP verweist in `shell_command.cfg` urspruenglich auf `/home/mks/plr.sh` und `/home/mks/clear_plr.sh`. Im bereinigten Paket wurden diese Pfade auf `~/printer_data/config/` korrigiert, weil die Skripte dort mitgeliefert werden.

## Empfehlungen

- Dieses Paket als neuen GitHub-Stand verwenden.
- Falls `alt autotune_tmc.cfg` im bestehenden GitHub-Repo nicht mehr gebraucht wird, in GitHub manuell loeschen.
- Nach dem Upload am Drucker `chmod +x` fuer `plr.sh`, `clear_plr.sh` und `macro_beep.sh` ausfuehren.
- Danach Firmware neu starten und die Testliste aus `README.md` durchgehen.
