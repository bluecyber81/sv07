#!/usr/bin/env bash
set -euo pipefail

CFG="/home/mks/printer_data/config/saved_variables.cfg"
PLR_PATH="$HOME/printer_data/gcodes/plr"

mkdir -p "$PLR_PATH"

decode_var() {
  printf '%b' "$1"
}

is_number() {
  [[ "$1" =~ ^-?[0-9]+([.][0-9]+)?$ ]]
}

if [[ ! -f "$CFG" ]]; then
  echo "PLR: saved_variables.cfg nicht gefunden: $CFG" >&2
  exit 1
fi

filepath_raw=$(sed -n "s/.*filepath *= *'\([^']*\)'.*/\1/p" "$CFG" | head -n1)
last_file_raw=$(sed -n "s/.*last_file *= *'\([^']*\)'.*/\1/p" "$CFG" | head -n1)
saved_height=$(sed -n "s/.*power_resume_z *= *\([^[:space:]]*\).*/\1/p" "$CFG" | head -n1)

filepath=$(decode_var "${filepath_raw:-}")
last_file=$(decode_var "${2:-${last_file_raw:-}}")
height="${1:-${saved_height:-}}"

if [[ -z "$filepath" ]]; then
  echo "PLR: filepath fehlt in saved_variables.cfg" >&2
  exit 1
fi

if [[ -z "$last_file" ]]; then
  echo "PLR: last_file fehlt in saved_variables.cfg oder Parameter 2" >&2
  exit 1
fi

# RUN_SHELL_COMMAND kann last_file mit Anfuehrungszeichen uebergeben.
last_file="${last_file%\"}"
last_file="${last_file#\"}"

if [[ "$last_file" == */* ]]; then
  echo "PLR: last_file darf kein Pfad sein: $last_file" >&2
  exit 1
fi

if [[ ! -f "$filepath" ]]; then
  echo "PLR: Originaldatei nicht gefunden: $filepath" >&2
  exit 1
fi

if [[ -z "$height" ]]; then
  echo "PLR: power_resume_z fehlt in saved_variables.cfg oder Parameter 1" >&2
  exit 1
fi

if ! is_number "$height"; then
  echo "PLR: ungueltige Z-Hoehe: $height" >&2
  exit 1
fi

python3 - "$filepath" "$height" "$PLR_PATH/$last_file" <<'PY'
import sys
import re
from pathlib import Path

src = Path(sys.argv[1])
target = float(sys.argv[2])
dst = Path(sys.argv[3])

lines = src.read_text(errors="ignore").splitlines()

# Thumbnailblock entfernen, damit die Resume-Datei kleiner und sauberer bleibt.
clean = []
skip = False
for line in lines:
    line = line.rstrip("\r")
    if line.startswith("; Sovol3D thumbnail begin"):
        skip = True
        continue
    if skip:
        if line.startswith("; Sovol3D thumbnail end"):
            skip = False
        continue
    clean.append(line)

if not clean:
    raise SystemExit("PLR: G-Code-Datei ist leer oder konnte nicht gelesen werden.")

z_re = re.compile(r'(?<!\S)Z(-?\d+(?:\.\d+)?)')
e_re = re.compile(r'(?<!\S)E(-?\d+(?:\.\d+)?)')

meta_prefixes = (";TIME:", ";Layer height:", ";MINX:", ";MINY:", ";MINZ:", ";MAXX:", ";MAXY:", ";MAXZ:")
meta = []
seen = set()
for ln in clean:
    if ln.startswith(meta_prefixes) and ln not in seen:
        meta.append(ln)
        seen.add(ln)

gen_line = next((ln for ln in clean if ln.startswith(";Generated with")), ";Generated with PLR resume")

joined = "\n".join(clean)
bed_temp_match = re.search(r'material_bed_temperature\s*=\s*([0-9]+(?:\.\d+)?)', joined)
nozzle_temp_match = re.search(r'material_print_temperature\s*=\s*([0-9]+(?:\.\d+)?)', joined)

bed_temp_fallback = bed_temp_match.group(1) if bed_temp_match else None
nozzle_temp_fallback = nozzle_temp_match.group(1) if nozzle_temp_match else None

resume_idx = None
resume_z = None
last_e = None
last_m104 = None
last_m109 = None
last_m140 = None
last_m190 = None
last_m106 = None
last_coord_mode = None
last_extruder_mode = None

for idx, ln in enumerate(clean):
    stripped = ln.strip()

    if stripped == "G90":
        last_coord_mode = "G90"
    elif stripped == "G91":
        last_coord_mode = "G91"
    elif stripped == "M82":
        last_extruder_mode = "M82"
    elif stripped == "M83":
        last_extruder_mode = "M83"

    if stripped.startswith("M104"):
        last_m104 = stripped
    elif stripped.startswith("M109"):
        last_m109 = stripped
    elif stripped.startswith("M140"):
        last_m140 = stripped
    elif stripped.startswith("M190"):
        last_m190 = stripped
    elif stripped.startswith("M106"):
        last_m106 = stripped

    e_match = e_re.search(ln)
    if e_match:
        last_e = e_match.group(1)

    z_match = z_re.search(ln)
    if z_match:
        z_val = float(z_match.group(1))
        if z_val >= target - 1e-4:
            resume_idx = idx
            resume_z = z_match.group(1)
            break

if resume_idx is None or resume_z is None:
    raise SystemExit(f"PLR: Kein passender Resume-Punkt fuer Z >= {target} gefunden.")

# Fallback fuer E nur falls noetig.
if last_e is None:
    for ln in clean[resume_idx:]:
        e_match = e_re.search(ln)
        if e_match:
            last_e = e_match.group(1)
            break

# Temperatur-Fallbacks aus Dateikommentaren, falls keine M104/M109/M140/M190 im G-Code vorhanden sind.
if last_m140 is None and bed_temp_fallback is not None:
    last_m140 = f"M140 S{bed_temp_fallback}"
if last_m190 is None and bed_temp_fallback is not None:
    last_m190 = f"M190 S{bed_temp_fallback}"
if last_m104 is None and nozzle_temp_fallback is not None:
    last_m104 = f"M104 S{nozzle_temp_fallback}"
if last_m109 is None and nozzle_temp_fallback is not None:
    last_m109 = f"M109 S{nozzle_temp_fallback}"

out = []
out.append("; PLR resume file")
out.append(f"; source={src.name}")
out.extend(meta)
out.append(gen_line)
out.append(f"SET_KINEMATIC_POSITION Z={resume_z}")

# Nur bei absoluter Extrusion noetig/sinnvoll.
if last_e is not None and last_extruder_mode != "M83":
    out.append(f"G92 E{last_e}")

out.append('M118 PLR: Resume wird vorbereitet...')
out.append("G91")
out.append("G1 Z10 F600")
out.append("G90")
out.append("G28 X Y")
out.append(f"SET_KINEMATIC_POSITION Z={resume_z}")

if last_coord_mode:
    out.append(last_coord_mode)
if last_extruder_mode:
    out.append(last_extruder_mode)

if last_m140:
    out.append(last_m140)
if last_m104:
    out.append(last_m104)
if last_m190:
    out.append(last_m190)
if last_m109:
    out.append(last_m109)
if last_m106:
    out.append(last_m106)

out.extend(clean[resume_idx:])

dst.write_text("\n".join(out) + "\n")
print(f"PLR: Resume-Datei erstellt: {dst}")
print(f"PLR: Resume ab Z={resume_z} (angefordert: {target})")
PY
