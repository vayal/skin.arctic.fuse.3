# Screen-by-Screen Build Contract (non-list surfaces)

**List feeds** (`list_id`, D-015, skin vs addon alignment) are **not** maintained here anymore. Use the three directories **`doc/contracts/`** (theory), **`doc/target/`** (this file’s sibling `LIST_CONTRACTS_TARGET.md`), **`doc/status/`** (`LIST_IMPLEMENTATION_STATUS.md`):

- [doc/contracts/README.md](../contracts/README.md) — addon list **theory** (index)  
- [LIST_ADDON_THEORY.md](../contracts/LIST_ADDON_THEORY.md) — addon list/rails theory  
- [LIST_CONTRACTS_TARGET.md](./LIST_CONTRACTS_TARGET.md) — required lists + hub row **target**  
- [LIST_IMPLEMENTATION_STATUS.md](../status/LIST_IMPLEMENTATION_STATUS.md) — current **status** + list backlog  

This file keeps **non-list** product direction: details/OSD/context, removals, search UX (tabs), generator workflow, and file index for those concerns.

---

## Target (non-list)

**Details / context / OSD — direction:** Full-screen details as canonical “Info”; lean rails; context menu **curated**; remove playlist OSD, cast OSD, PVR in fork where decided; OSD next-recommendation per product. **Files:** `DialogVideoInfo.xml`, `Includes_DialogInfo.xml`, `Dialog_DialogContextMenu.xml`, `Includes_OSD.xml`, etc.

**Remove / simplify (high level):** Home submenu static strip; NextAired as primary home rail; user-facing shortcut editor; PVR entry points; OSD 1140/1141/1143 per policy; `TMDbHelper` / legacy property retirement where feasible (D-038).

**SkinVariables generator (required workflow):**  
`1080i/script-skinvariables-generator-includes.xml` is **generated output**. Edits to hub widget rows that must survive regen go through **`shortcuts/skinvariables-generator.json`**, **`shortcuts/generator/data/…`**, shortcut JSONs (e.g. `shortcuts/skinvariables-shortcut-1101widgets.json`), then regenerate and commit **sources + output** together.

**Freeze / docs pointers:** D-003 display mode matrix, D-021 context keep/remove, D-038 legacy exceptions — see [target README](./README.md) and [velocity D-038](../velocity/d038-legacy-property-ledger.md).

---

## Remaining implementation plan (non-list excerpts)

### OSD & playback

- [ ] Remove **1140** playlist OSD: file + `ActivateWindow(1140)` / actions in `Includes_Actions`, seekbar, expressions  
- [ ] Remove all **1141** references; confirm no required XML  
- [ ] **1143** next overlay: remove or hard-disable  
- [ ] Pause overlay + “first Info → light overlay, second → full details” — align `Custom_1193`, `Includes_OSD`

### PVR removal

- [ ] Map entry points (`Home`, `Settings`, `tvchannels`, PVR dialogs); remove or block user-visible paths  
- [ ] `Includes.xml` PVR includes: policy (delete vs unreachable stub)

### Submenu & shortcut editor

- [ ] Remove or hide `skinvariables-homesubmenu-staticitems` from `Includes_Home` (+ generator `home_submenu.xml`)  
- [ ] Remove `ActivateWindow(1115)` from user settings or gate to dev-only

### Details & context

- [ ] D-021: keep/remove table for `Dialog_DialogContextMenu` → apply  
- [ ] Details lean pass: `Includes_DialogInfo` / `DialogVideoInfo`  
- [ ] D-038: grep + exception list in ledger

### NextAired on home

- [ ] Contract: not on Home main rail; confirm `Home.xml` / `Includes_NextAired` usage; trim if still user-visible in wrong place

---

## Reference (file index — non-exhaustive)

| Concern | Typical files |
|--------|----------------|
| Hubs / widgets (list wiring lives in **contracts/**) | `1080i/Includes_Hubs.xml`, `Includes_Home.xml`, `Includes_Widgets.xml` |
| Generated includes | `1080i/script-skinvariables-generator-includes.xml` (output) |
| Generator inputs | `shortcuts/skinvariables-generator.json`, `shortcuts/generator/data/`, `shortcuts/skinvariables-shortcut-*.json` |
| Startup / spotlight | `1080i/Startup.xml`, `shortcuts/skinvariables-splash.json`, `shortcuts/skinvariables-startup.json` |
| Search chrome | `1080i/Custom_1105_Search.xml`, `1080i/Includes_Search.xml`, `shortcuts/generator/data/setup/search_path.xml` |

---

*End of document.*
