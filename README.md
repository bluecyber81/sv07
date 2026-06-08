# SV07 Klipper Backup

Sauber strukturierter Klipper-Backup-Stand für einen **Sovol SV07 / SV07 Plus** mit Klipad/MKS-Host.

Dieses Repository enthält den aktiven Klipper-Konfigurationsstand, Hilfsskripte und kurze Wartungsdokumentation. Ziel ist nicht, blind maximale Geschwindigkeit einzustellen, sondern einen stabilen, nachvollziehbaren und wiederherstellbaren Druckerstand zu behalten.

## Ziel

Dieses Repo soll genau drei Dinge zuverlässig leisten:

1. den **aktiven Klipper-Stand** sichern,
2. **Hilfsskripte und Makros** nachvollziehbar halten,
3. **Altlasten und Backup-Müll** vom Live-Setup trennen.

## Aktiver Einstiegspunkt

Der wichtigste Einstiegspunkt ist:

```text
printer_data/config/printer.cfg
```

Dort werden aktuell unter anderem eingebunden:

```text
[include shell_command.cfg]
[include mainsail.cfg]
[include plr.cfg]
[include timelapse.cfg]
[include printer_additions/___module_loader.cfg]
[include autotune_tmc.cfg]
```

## Empfohlene Struktur

```text
.
├── README.md
├── .gitignore
├── docs/
│   ├── APPLY_CHANGES.md
│   └── REPO_REVIEW.md
└── printer_data/
    └── config/
        ├── printer.cfg
        ├── shell_command.cfg
        ├── plr.cfg
        ├── timelapse.cfg
        ├── saved_variables.cfg
        ├── macro/
        │   └── macro_beep.sh
        └── printer_additions/
```

## Was im Repo bleiben sollte

- `printer.cfg` als aktiver Einstiegspunkt
- bewusst genutzte Includes wie `shell_command.cfg`, `plr.cfg`, `timelapse.cfg`
- sauber benannte Hilfsskripte
- dokumentierte Drittanbieter-Module in `printer_additions/`
- kleine Doku-Dateien unter `docs/`

## Was nicht in den Live-Bereich gehört

- alte `printer-YYYYMMDD_*.cfg` Snapshots
- `config-*.zip` Sicherungen
- `.deb` Pakete
- doppelte oder veraltete Shell-Skripte
- temporäre Mess-, Log- und CSV-Dateien
- generierte Resonanz- oder Kalibrierungsdateien

## Wartungsregeln

- Nur **eine** aktive Beep-Datei verwenden: `printer_data/config/macro/macro_beep.sh`
- alte Config-Snapshots entweder löschen oder nach `archive/` verschieben
- generierte Daten nicht erneut tracken
- Änderungen an `printer.cfg` in logischen Blöcken kommentieren
- Hardwarewerte nur ändern, wenn der Drucker danach gezielt getestet wird

## Nach Änderungen testen

Nach Änderungen an Makros oder Shell-Kommandos am Drucker testen:

```text
BEEP
START_PRINT
PAUSE
RESUME
END_PRINT
update_git
```

Beim Beep-Skript außerdem sicherstellen:

```bash
chmod +x printer_data/config/macro/macro_beep.sh
```

## Hinweis

Diese Überarbeitung ändert **keine aggressiven Hardware-Tuning-Werte** absichtlich. Ziel ist zuerst Ordnung, Wartbarkeit und Robustheit.
