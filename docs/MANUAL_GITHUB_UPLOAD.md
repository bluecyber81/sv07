# Manueller GitHub-Upload (ZIP)

## Ziel
Wenn du lokal nicht per `git push` arbeiten willst, kannst du dieses Repository als ZIP exportieren und über GitHub Web manuell hochladen.

## ZIP erzeugen
Im Repo-Root ausführen:

```bash
bash scripts/create_github_upload_zip.sh
```

Ergebnis:
- ZIP liegt in `release/`
- Dateiname: `sv07-github-upload-YYYY-MM-DD.zip`

## Was im ZIP **nicht** enthalten ist
- `.git/` Metadaten
- bereits erzeugte ZIP-Dateien in `release/`
- Cache-/Temp-Dateien (`__pycache__`, `.DS_Store`)

## Upload in GitHub (Web)
1. Auf GitHub dein Ziel-Repository öffnen.
2. `Add file` → `Upload files`.
3. Inhalt der ZIP lokal entpacken.
4. Entpackte Dateien per Drag & Drop hochladen.
5. Commit-Message eintragen, z. B. `Manual upload: sv07 config refresh`.
6. `Commit changes` klicken.

## Hinweis
Wenn dein Ziel bereits Dateien enthält, achte auf Überschreibungen (vor allem in `printer_data/config/`).
