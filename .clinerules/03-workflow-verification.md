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

## Roadmap Phase Verification

### Phase 2 Verification
- Verify generator source changes before regenerating
- Confirm generated output matches intended route updates
- Commit source + generated output together

### Phase 3 Verification
- Verify D-021 context menu decisions in Dialog_DialogContextMenu.xml
- Verify OSD windows policy for 1140/1141/1143
- Verify search chrome tab/alias policy
- Verify inventory decisions (keep/remove/defer)

### Phase 4 Verification
- Validate browse-to-play journey (Home/Series/Movies)
- Validate search-to-play journey
- Validate info-and-related journey
- Validate D-015 runtime pagination behavior
- Validate D-003/D-021/D-038 runtime policy conformance
- Run full operator checklist and freeze matrix

### Phase 5 Verification
- Run helper grep across XML/JSON
- Classify each hit as remove/replace/accepted exception
- Reconcile remaining helper hits into D-038 exceptions
- Verify PVR behavior under with/without addon/channels matrix

## Evidence Capture
- Diff links for updated route wiring
- Regen proof (source inputs + generated output updated)
- Contract alignment matrix revision note
- Runtime validation handoff list for Phase 4
- Grep snapshot before and after each debt batch
- D-038 diff entries for each accepted exception
