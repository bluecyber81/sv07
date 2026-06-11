# SV07 Klipper Backup

Aktueller, GitHub-bereinigter Klipper-Backup-Stand fuer einen **Sovol SV07 / SV07 Plus** mit Klipad/MKS-Host.

Dieses Repo soll den funktionierenden Druckerstand nachvollziehbar sichern, ohne Logdateien, Installer-Pakete oder alte Export-ZIPs mitzuschleppen.

## Aktueller Stand

- Quelle: `config-20260608.zip`
- Ziel-Repo: `bluecyber81/sv07`
- Hauptkonfiguration: `printer_data/config/printer.cfg`
- Bereinigt fuer GitHub: Logs und `.deb`-Pakete sind nicht enthalten.

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
        |   |-- macro_beep.sh
        |   `-- 1macro_beep.sh
        `-- printer_additions/
```

## PLR / Power-Loss-Resume

Die PLR-Makros liegen in `plr.cfg`. Die zugehoerigen Shell-Skripte liegen im Config-Ordner und werden von `shell_command.cfg` so aufgerufen:

```text
/home/mks/printer_data/config/clear_plr.sh
/home/mks/printer_data/config/plr.sh
```

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
- G-Code-Dateien aus `printer_data/gcodes/`
- lokale Datenbanken, Zertifikate und Runtime-Sockets

## Nach Aenderungen testen

Nach dem Upload und einem Firmware Restart am Drucker pruefen:

```text
BEEP
G31
START_PRINT
PAUSE
RESUME
END_PRINT
SFS_ENABLE
SFS_DISABLE
```

Bei PLR nur testen, wenn `last_file` und `power_resume_z` plausibel gesetzt sind.
