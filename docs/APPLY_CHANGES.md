# Aenderungen anwenden

Diese Datei beschreibt, wie der aktuelle GitHub-Stand sauber auf den Drucker uebernommen und getestet wird.

## 1. Repo auf dem Drucker aktualisieren

Auf dem Klipad/MKS-Host im passenden Backup-/Config-Verzeichnis aktualisieren, je nachdem wie dein lokaler Git-Stand eingerichtet ist.

Typischer Ablauf:

```bash
cd ~/printer_data/config
git pull
```

Falls dein `klipper-backup`-Workflow die Dateien anders synchronisiert, nutze deinen gewohnten Sync-Weg und pruefe danach die Dateien in `~/printer_data/config`.

## 2. Shell-Skripte ausfuehrbar machen

GitHub-Web-Uploads erhalten Ausfuehrungsrechte nicht immer sauber. Deshalb einmal ausfuehren:

```bash
chmod +x ~/printer_data/config/clear_plr.sh
chmod +x ~/printer_data/config/plr.sh
chmod +x ~/printer_data/config/macro/macro_beep.sh
```

## 3. Nicht benoetigte Doppeldateien entfernen

Im aktiven Config-Ordner sollte es nur eine Beep-Datei geben:

```text
~/printer_data/config/macro/macro_beep.sh
```

Falls lokal noch vorhanden, entfernen:

```bash
rm -f ~/printer_data/config/macro/1macro_beep.sh
rm -f ~/printer_data/config/macro-beep.sh
rm -f ~/printer_data/config/macro_beep.sh
```

## 4. Klipper neu starten

In Mainsail/Klipper:

```text
FIRMWARE_RESTART
```

oder ueber die Weboberflaeche neu starten.

## 5. Funktionstest

Nach dem Neustart testen:

```text
BEEP
BEEP BC=1 BD=0.1 PD=0.2
G31
SFS_ENABLE
SFS_DISABLE
PAUSE
RESUME
END_PRINT
```

`START_PRINT` nur mit Slicer-/Testdatei ausfuehren, nicht leer in der Konsole.

## 6. PLR-Hinweis

`RESUME_INTERRUPTED` ist nur fuer Power-Loss-Resume gedacht. Nicht als normales Resume verwenden.

Vor einem PLR-Test in `saved_variables.cfg` pruefen:

```text
last_file
filepath
power_resume_z
was_interrupted
print_is_running_f
```

Nur fortsetzen, wenn Datei und Z-Hoehe plausibel sind.
