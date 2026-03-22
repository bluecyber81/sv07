Dieses Paket ist eine bereinigte, konsolidierte Version deines öffentlichen Repos.

Wichtige Änderungen
-------------------
- `channel: dev` bleibt in `moonraker.conf` unverändert.
- Doppeldefinitionen wurden entfernt:
  - `beep` liegt nur noch in `shell_command.cfg`
  - `clear_plr` und `POWER_LOSS_RESUME` liegen nur noch in `shell_command.cfg`
  - `respond` und `save_variables` bleiben nur noch in `printer.cfg`
- `printer.cfg` wurde formatiert und die Makros vorsichtig verbessert.
- `plr.cfg` enthält nur noch PLR-relevante Makros.
- `macro/macro_beep.sh` wurde robuster gemacht.
- README und `.gitignore` wurden deutlich verbessert.

Empfohlene Übernahme
--------------------
1. Backup deiner laufenden Dateien anlegen.
2. Diese Dateien übernehmen:
   - `README.md`
   - `.gitignore`
   - `printer_data/config/printer.cfg`
   - `printer_data/config/plr.cfg`
   - `printer_data/config/shell_command.cfg`
   - `printer_data/config/moonraker.conf`
   - `printer_data/config/crowsnest.conf`
   - `printer_data/config/macro/macro_beep.sh`
3. Danach `RESTART` in Klipper / Moonraker.
4. Erst danach das Repo aufräumen und Altdateien verschieben oder aus Git entfernen.

Wichtig
-------
Hardwarewerte wurden nicht absichtlich verändert. Der Stepper-/Heater-/Probe-Teil stammt aus deiner bestehenden `printer.cfg` und wurde nur im Makrobereich bereinigt.
