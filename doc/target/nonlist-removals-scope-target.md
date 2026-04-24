# Non-list target — removals and simplifications

**Truth type:** product **target** (scope of what to remove or hide). Implementation tracking lives in the matching **status** docs under [nonlist-surfaces-index.md](nonlist-surfaces-index.md).

## High-level removals / simplifications

- **Home submenu** static strip (generator-driven home submenu items) — remove or hide from shipped UX when product agrees.
- **NextAired** must **not** be the primary Home main rail; see [nonlist-nextaired-home-status.md](../status/nonlist-nextaired-home-status.md).
- **User-facing shortcut editor** — out of scope for Velocity fork unless explicitly re-enabled for dev builds.
- **PVR** entry points and surfaces — remove or block user-visible paths per fork policy.
- **Specific OSD windows** — **1140** (playlist OSD), **1141**, **1143** (next overlay) — remove, stub, or hard-disable per policy; see OSD status doc.
- **`TMDbHelper` / legacy skin properties** — retire where feasible; exceptions live in **D-038** ([../context/d038-legacy-properties-and-mapping.md](../context/d038-legacy-properties-and-mapping.md)).

## Doc freeze pointers

- **D-003** — hub / window IDs and view-mode locking: [d003-view-mode-matrix.md](d003-view-mode-matrix.md)
- **D-021** — context menu keep/remove: status checklist + ledger notes as they exist
- **D-038** — legacy property exceptions: [../context/d038-legacy-properties-and-mapping.md](../context/d038-legacy-properties-and-mapping.md)
