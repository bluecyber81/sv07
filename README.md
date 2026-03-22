# sv07

Sauber strukturierter Klipper-Backup-Stand für einen **Sovol SV07**.

Das ursprüngliche Repository ist ein funktionaler Klipper-Backup-Dump. Diese überarbeitete Fassung macht den Stand leichter wartbar, besser dokumentiert und sicherer zu pflegen.

## Ziel

Dieses Repo soll genau drei Dinge zuverlässig leisten:

1. den **aktiven Klipper-Stand** sichern,
2. **Hilfsskripte und Makros** nachvollziehbar halten,
3. **Altlasten und Backup-Müll** vom Live-Setup trennen.

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

## Was **nicht** im Live-Bereich liegen sollte

- alte `printer-YYYYMMDD_*.cfg` Snapshots
- `config-*.zip` Sicherungen
- `.deb` Pakete
- doppelte oder veraltete Shell-Skripte
- temporäre Mess- und CSV-Dateien

## Wartungsregeln

- Nur **eine** aktive Beep-Datei verwenden: `printer_data/config/macro/macro_beep.sh`
- alte Config-Snapshots entweder löschen oder nach `archive/` verschieben
- generierte Daten nicht erneut tracken
- Änderungen an `printer.cfg` in logischen Blöcken kommentieren

## Sichere Update-Reihenfolge

1. Dateien aus `sv07_improvements/` übernehmen
2. Backup-Dateien aus dem aktiven Config-Ordner entfernen oder enttracken
3. `chmod +x printer_data/config/macro/macro_beep.sh`
4. Klipper `SAVE & RESTART`
5. Testen:
   - `BEEP`
   - `START_PRINT`
   - `PAUSE`
   - `RESUME`
   - `END_PRINT`

## Hinweis

Diese Überarbeitung ändert **keine aggressiven Hardware-Tuning-Werte** absichtlich. Ziel ist zuerst Ordnung, Wartbarkeit und Robustheit.
