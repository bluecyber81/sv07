# Änderungen anwenden

## 1. Dateien ersetzen
Diese Dateien aus diesem Paket in dein Repo kopieren:

- `README.md`
- `.gitignore`
- `printer_data/config/shell_command.cfg`
- `printer_data/config/macro/macro_beep.sh`

## 2. Bereits getrackte Backup-Dateien aus Git entfernen
Nur `.gitignore` reicht nicht, wenn die Dateien schon im Repo liegen.

Beispiel:

```bash
git rm --cached printer_data/config/config-*.zip
git rm --cached printer_data/config/*.deb
git rm --cached printer_data/config/printer-[0-9]*_[0-9]*.cfg
```

Falls du alte Stände behalten willst, verschiebe sie vorher lokal in einen Archiv-Ordner.

## 3. Doppelte Dateien bereinigen
Empfohlen:

- `printer_data/config/macro_beep.sh` entfernen, falls ungenutzt
- `printer_data/config/macro-beep.sh` entfernen, falls ungenutzt
- nur `printer_data/config/macro/macro_beep.sh` behalten

## 4. Shell-Skript ausführbar machen

```bash
chmod +x printer_data/config/macro/macro_beep.sh
```

## 5. Commit

```bash
git add .
git commit -m "Clean up sv07 repo structure and helper scripts"
git push
```

## 6. Danach am Drucker testen

- `BEEP`
- `START_PRINT`
- `PAUSE`
- `RESUME`
- `END_PRINT`
- `update_git`
