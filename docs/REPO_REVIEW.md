# Repo-Review für `bluecyber81/sv07`

## Was aktuell gut ist

- Live-Konfiguration liegt grundsätzlich im erwarteten `printer_data/config/`-Pfad.
- `printer.cfg` bindet Zusatzdateien wie `shell_command.cfg`, `plr.cfg` und `timelapse.cfg` bereits ein.
- Drittanbieter-Module in `printer_additions/` sind separat abgelegt.

## Hauptprobleme

### 1) Live-Config und Archiv sind vermischt
Im aktiven Konfigurationsordner liegen gleichzeitig:
- mehrere `printer-*.cfg`
- mehrere `config-*.zip`
- `.deb`-Pakete
- alternative / alte Printer-Dateien
- doppelte Beep-Skripte

Das macht Fehleranalyse, Restore und Review unnötig schwer.

### 2) README erklärt das Repo praktisch nicht
Das Standard-`klipper-backup`-README ist zu knapp für einen echten Wartungsstand.

### 3) `.gitignore` ist zu knapp
Zwar werden einige Dateitypen ignoriert, aber nur zukünftig. Bereits getrackte Backup-Dateien bleiben trotzdem im Repo.

### 4) Hilfsskripte sind nicht sauber vereinheitlicht
Insbesondere beim Beeper gibt es mehrere Dateinamen und Pfade. Das sollte auf genau **eine** Datei reduziert werden.

### 5) `printer.cfg` ist funktional, aber schwer wartbar
Die Datei mischt:
- Druck-Makros
- Sensorik
- Stepper / Heizer
- Bett-Leveling
- externe Module
- SAVE_CONFIG-Block

Das ist für den Drucker okay, aber für Git-Pflege unübersichtlich.

## Empfohlene nächste Schritte

1. Nur die aktive Config im Live-Pfad behalten.
2. Alte Snapshots nach `archive/` verschieben oder aus Git entfernen.
3. `.deb` und ZIPs aus dem Repo enttracken.
4. README und `.gitignore` ersetzen.
5. `shell_command.cfg` und `macro_beep.sh` vereinheitlichen.
6. Danach optional `printer.cfg` modularisieren.

## Optionaler zweiter Schritt

Wenn die Aufräumrunde stabil läuft, dann im nächsten Commit:
- Makros in eigene Include-Dateien auslagern
- Motion / Heater / Sensors logisch trennen
- generierte SAVE_CONFIG-Daten bewusst unten isolieren
