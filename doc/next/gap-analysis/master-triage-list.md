# Master triage — open items only

Prior bucket lists were removed (2026-04-24). Items below were **re-verified against the tree** (`rg`, file presence). Treat everything else as closed or tracked only in git history.

## 1) Phase 07 — runtime (still required)

- [ ] Capture **Kodi** evidence for browse / hub / provider / search / info journeys and append to [Phase 07 playbook §Validation status](../roadmap/phase-07-stabilization-and-freeze.md#validation-status-and-blockers), per [kodi-complete-testing guide](../../velocity/kodi-complete-testing-guide.md).
- [ ] At runtime, confirm **D-015** pagination payloads (`items/page/has_more/next_page`) and **in-row cap / full list / empty state** vs [LIST_CONTRACTS_TARGET.md](../../target/LIST_CONTRACTS_TARGET.md) and [LIST_IMPLEMENTATION_STATUS.md](../../status/LIST_IMPLEMENTATION_STATUS.md).

## 2) Legacy helper / property debt (code still present)

Re-run: `rg -i "tmdbhelper|themoviedb\\.helper" --glob "*.xml" --glob "*.json"` from repo root.

**Still matches (non-exhaustive, 2026-04-24):** `Includes_Images.xml`, `Includes_Overlay.xml`, `Includes_DialogInfo.xml`, `Includes_Search.xml`, `Includes_Widgets.xml`, `Includes_Views_Combined.xml`, `Custom_1140_OSD_Playlist.xml`, and related surfaces — see **[D-038](../../velocity/d038-legacy-property-ledger.md)** for approved vs deferred symbols (e.g. discover folder path key, OSD crop, crew strip). (`Includes_Hubs.xml` is Velocity `list_id` wiring; grep it separately if re-auditing.)

**Concrete follow-ups**

- [ ] Rename or neutralize **`Window(home).property(tmdbhelper.userdiscover.folderpath)`** usage in search/discover wiring when product accepts the breaking change (ledger §4).
- [ ] Replace remaining **`TMDbHelper.Player.CropImage`** / **`TMDbHelper.WidgetContainer`** / **`TMDbHelper.ListItem.*`** bindings per D-038 batches (do not delete ledger rows without code change).

## 3) PVR gating (product / skin)

- [ ] **`Includes_Home.xml`** still uses `System.HasPVRAddon + PVR.HasTVChannels` for Live TV / 1107 routing (3 occurrences). Decide: keep for Kodi PVR users, replace with Velocity-only gating, or hide toggle per product.

## 4) Deleted gap reports

Per-folder `phase-*-gap.md` files were **deleted** (2026-04-24). Use this file + **target/** + **velocity/d038** as the working backlog.
