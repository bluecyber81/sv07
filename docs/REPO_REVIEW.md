# Repo-Analyse fuer `bluecyber81/sv07`

Stand der Analyse: 2026-06-11

## Ergebnis

Das GitHub-Repo `bluecyber81/sv07` ist jetzt deutlich sauberer als ein roher Druckerexport. Es enthaelt README, `.gitignore`, Doku, die aktive Klipper-Konfiguration, PLR-Skripte und genau ein aktives Beep-Skript.

## Gute Punkte

- Repo-Struktur liegt im erwarteten Pfad `printer_data/config/`.
- `printer.cfg` ist der klare Einstiegspunkt.
- Die aktive Include-Kette wurde geprueft: Es fehlen keine aktiven Includes.
- KPA-Module sind unter `printer_additions/` getrennt.
- `.gitignore` filtert ZIPs, Logs, `.deb`-Pakete, Runtime-Daten und doppelte Helper-Skripte.
- Logs und Installer-Pakete werden nicht als normaler Repo-Inhalt behandelt.

## Erledigte Bereinigung

- Doppelte Datei `printer_data/config/macro/1macro_beep.sh` entfernt.
- Aktives Beep-Skript `printer_data/config/macro/macro_beep.sh` gehaertet.
- `clear_plr.sh` mit Sicherheitsschutz gegen falsche Loeschpfade verbessert.
- `plr.sh` verbessert: Parameter aus `RESUME_INTERRUPTED` werden jetzt bevorzugt, `saved_variables.cfg` bleibt Fallback.
- README an den echten aktuellen Stand angepasst.
- `.gitignore` erweitert, damit doppelte Helper-Dateien nicht wieder versehentlich hochgeladen werden.

## Technische Befunde

- `shell_command.cfg` verweist auf die richtigen Skriptpfade unter `/home/mks/printer_data/config/`.
- `RESUME_INTERRUPTED` uebergibt `Z_HEIGHT` und `last_file`; `plr.sh` nutzt diese Werte jetzt wirklich.
- `macro_beep.sh` nutzt weiterhin GPIO82, prueft aber Parameter und schaltet bei Abbruch sicher aus.
- Hardwarewerte wie Stepper, PID, Mesh, Shaper und Beschleunigung wurden absichtlich nicht veraendert.

## Wichtig am Drucker

Nach dem Sync auf den Drucker ausfuehren:

```bash
chmod +x ~/printer_data/config/clear_plr.sh
chmod +x ~/printer_data/config/plr.sh
chmod +x ~/printer_data/config/macro/macro_beep.sh
```

Danach testen:

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

## Naechste sinnvolle Schritte

- Einen echten Testdruck mit KPA-Startcode machen.
- Danach `saved_variables.cfg` pruefen: `last_file`, `filepath`, `power_resume_z`, `was_interrupted`, `print_is_running_f`.
- PLR nur kontrolliert testen, wenn die gespeicherten Werte plausibel sind.
- Optional spaeter: `printer.cfg` weiter in Module aufteilen, aber erst nach erfolgreichem Testdruck.
