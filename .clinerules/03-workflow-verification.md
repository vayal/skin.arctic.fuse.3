# 3. Agent Verification Workflow

You must verify your own work when editing the skin. Do not assume your JSON/XML edits are correct.

## The Sync Loop
1. Make your changes to the blueprints/JSON.
2. Open the terminal and run the sync script (usually located at `./tools/kodi-sync.sh`).
3. Check the terminal output:
   - If `git status 1080i/` shows modified files, the generator accepted your code.
   - If there are NO changes, you made a syntax error (like a trailing comma in JSON).

## Flatpak Log Debugging
If the generator fails silently, you must read the Kodi log inside the Flatpak sandbox to find your traceback:
Run: `tail -n 50 /home/mfuch/.var/app/tv.kodi.Kodi/data/temp/kodi.log`
Read the error, fix the blueprint, and run the sync script again.