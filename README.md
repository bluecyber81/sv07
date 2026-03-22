# Sovol SV07 Klipper Configuration

This repository contains my current Klipper, Moonraker, Crowsnest and helper-script configuration for a Sovol SV07.

## Included
- `printer.cfg`
- `plr.cfg`
- `moonraker.conf`
- `crowsnest.conf`
- `shell_command.cfg`
- custom macros and helper scripts
- timelapse and power-loss-resume related config

## Highlights
- custom `START_PRINT`, `PAUSE`, `RESUME`, `END_PRINT` and `CANCEL_PRINT`
- filament switch handling in `RESUME`
- centralized shell-command definitions
- bed mesh loading and `Z_TILT_ADJUST`
- dedicated beeper helper script
- cleaned public-repo structure

## Recommended repository layout
```text
printer_data/
└── config/
    ├── printer.cfg
    ├── plr.cfg
    ├── moonraker.conf
    ├── crowsnest.conf
    ├── shell_command.cfg
    ├── timelapse.cfg
    ├── macro/
    │   └── macro_beep.sh
    └── archive/
        ├── old-configs/
        └── generated-backups/
```

## Notes
This setup is hardware-specific.
Do not copy motor currents, endstops, probe offsets, heater settings or motion limits blindly to another machine.

The repository should keep only active configuration in the main config folder.
Generated ZIP backups, old experiments and package files should be archived or removed from Git tracking.
