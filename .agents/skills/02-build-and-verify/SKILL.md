---
name: 02-build-and-verify
description: Compiles the skin blueprints and checks for syntax errors in Flatpak logs
---

# 02-build-and-verify

Instructions for triggering the skinvariables generator and verifying the output.

## Usage
Use this after every file modification to ensure the code is valid and visible in Kodi.

## Steps
1. Execute `./tools/kodi-build.sh` in the WSL terminal.
2. Check for the "GENERATOR OUTPUT STATUS" header.
3. If no files in `1080i/` changed, read the Flatpak log: `tail -n 50 /home/mfuch/.var/app/tv.kodi.Kodi/data/temp/kodi.log`.
4. Locate the Python traceback/JSON error, fix the source file, and repeat.