# Aenderungen anwenden

## Manueller GitHub-Upload

Dieses Paket ist fuer den Upload in das Repo `bluecyber81/sv07` vorbereitet.

1. ZIP lokal entpacken.
2. Auf GitHub `bluecyber81/sv07` oeffnen.
3. `Add file` -> `Upload files`.
4. Den Inhalt dieses Paketordners hochladen, nicht den Ordner als zusaetzliche Unterebene.
5. Commit-Message zum Beispiel:

```text
Update SV07 Klipper config from 2026-06-08 backup
```

## Wichtig beim manuellen Upload

GitHub ersetzt Dateien, loescht aber alte Dateien nicht automatisch. Wenn du alte Dateien entfernen willst, loesche sie direkt im GitHub-Webinterface.

Empfohlen zu loeschen, falls noch vorhanden und nicht mehr bewusst genutzt:

```text
printer_data/config/alt autotune_tmc.cfg
printer_data/config/*.log
printer_data/config/macro/*.deb
```

## Danach auf dem Drucker

Nach dem Sync/Upload auf den Drucker:

```bash
chmod +x ~/printer_data/config/clear_plr.sh
chmod +x ~/printer_data/config/plr.sh
chmod +x ~/printer_data/config/macro/macro_beep.sh
```

Dann Klipper/Firmware neu starten und testen:

```text
BEEP
G31
START_PRINT
PAUSE
RESUME
END_PRINT
```

PLR-Resume nur testen, wenn die gespeicherte Datei und Z-Hoehe wirklich plausibel sind.
