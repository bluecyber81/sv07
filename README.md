# SV07 Klipper Backup

Aktueller, GitHub-bereinigter Klipper-Backup-Stand fuer einen **Sovol SV07 / SV07 Plus** mit Klipad/MKS-Host.

Dieses Repo soll den funktionierenden Druckerstand nachvollziehbar sichern, ohne Logdateien, Installer-Pakete, doppelte Hilfsskripte oder alte Export-ZIPs mitzuschleppen.

## Aktueller Stand

- Quelle: `config-20260608.zip`
- Ziel-Repo: `bluecyber81/sv07`
- Hauptkonfiguration: `printer_data/config/printer.cfg`
- Bereinigt fuer GitHub: Logs, `.deb`-Pakete, doppelte Beep-Skripte und alte Export-ZIPs sind nicht enthalten.

## Aktive Includes

`printer.cfg` bindet aktuell diese Dateien ein:

```text
[include shell_command.cfg]
[include plr.cfg]
[include timelapse.cfg]
[include printer_additions/___module_loader.cfg]
[include autotune_tmc.cfg]
[include printer_additions/kpa_leds_sv07plus_module.cfg]
```

Die Include-Kette wurde gegen die Dateien im Repo geprueft. Es fehlen keine aktiven Includes.

## Struktur

```text
.
|-- README.md
|-- .gitignore
|-- .gitattributes
|-- docs/
|   |-- APPLY_CHANGES.md
|   `-- REPO_REVIEW.md
`-- printer_data/
    `-- config/
        |-- printer.cfg
        |-- moonraker.conf
        |-- crowsnest.conf
        |-- shell_command.cfg
        |-- plr.cfg
        |-- plr.sh
        |-- clear_plr.sh
        |-- timelapse.cfg
        |-- saved_variables.cfg
        |-- macro/
        |   `-- macro_beep.sh
        `-- printer_additions/
```

## Beep / Buzzer

Aktive Datei:

```text
printer_data/config/macro/macro_beep.sh
```

Doppelte Altdateien wie `1macro_beep.sh`, `macro-beep.sh` oder `macro_beep.sh` im falschen Ordner sollen nicht verwendet werden. Das aktive Skript prueft Parameter, begrenzt die Anzahl der Beeps und schaltet GPIO82 bei Abbruch sicher aus.

## PLR / Power-Loss-Resume

Die PLR-Makros liegen in `plr.cfg`. Die zugehoerigen Shell-Skripte liegen im Config-Ordner und werden von `shell_command.cfg` so aufgerufen:

```text
/home/mks/printer_data/config/clear_plr.sh
/home/mks/printer_data/config/plr.sh
```

`plr.sh` bevorzugt jetzt die von `RESUME_INTERRUPTED` uebergebenen Parameter fuer `Z_HEIGHT` und `last_file`, faellt aber weiterhin auf `saved_variables.cfg` zurueck. Dadurch passen Makro und Shell-Skript besser zusammen.

Nach dem Upload auf den Drucker muessen die Shell-Skripte ausfuehrbar sein:

```bash
chmod +x ~/printer_data/config/clear_plr.sh
chmod +x ~/printer_data/config/plr.sh
chmod +x ~/printer_data/config/macro/macro_beep.sh
```

## Was bewusst nicht ins Repo gehoert

- `*.log`
- `*.deb`
- `config-*.zip`
- alte `printer-*.cfg` Snapshots
- doppelte Beep-/Hilfsskripte
- G-Code-Dateien aus `printer_data/gcodes/`
- lokale Datenbanken, Zertifikate und Runtime-Sockets

## Nach Aenderungen testen

Nach dem Upload und einem Firmware Restart am Drucker pruefen:

```text
BEEP
BEEP BC=1 BD=0.1 PD=0.2
G31
START_PRINT
PAUSE
RESUME
END_PRINT
SFS_ENABLE
SFS_DISABLE
```

Bei PLR nur testen, wenn `last_file` und `power_resume_z` plausibel gesetzt sind. `RESUME_INTERRUPTED` ist ein Notfall-/Power-Loss-Makro und kein normales Pause/Resume.
