# Phase 2 — Legacy helper & D-038 debt

**Parent:** [ROADMAP_MASTER.md](../ROADMAP_MASTER.md)

**Template:** [PHASE_TEMPLATE.md](./PHASE_TEMPLATE.md)

## Phase metadata

| Field | Value |
|-------|-------|
| Phase status | planned |
| Owner | TBD |
| Last updated | 2026-04-24 |
| In scope | See objective + work items |
| Out of scope | Anything not listed in work items |

Consolidates **open backlog** from the former `doc/next/gap-analysis/master-triage-list.md` (removed): helper/property debt, discover-folder key rename, and remaining grep hits — without mixing them into Phase 1 freeze evidence unless they **block** runtime verification.

---

## Objective

Drive the repo toward **zero undeclared** `TMDbHelper` / `themoviedb.helper` usage on migrated surfaces, or **explicit D-038** exceptions with owners. Product-breaking changes (e.g. discover folder property rename) are tracked here until accepted.

---

## Context & normative references

| Document | Role |
|----------|------|
| [D-038](../context/d038-legacy-properties-and-mapping.md) | Ledger + approved vs deferred symbols |
| [LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md) | List/search contract intent |
| [nonlist search chrome](./nonlist-search-chrome-target.md) | Search/discover product rules |
| [kodi best practices](../kodi/09_BEST_PRACTICES.md) | Generic skin hygiene |
| [traceability-by-topic](../traceability-by-topic.md) | Topic IDs |

---

## Audit command

Re-run from repo root:

```bash
rg -i "tmdbhelper|themoviedb\\.helper" --glob "*.xml" --glob "*.json"
```

**Still matches (non-exhaustive, 2026-04-24):** `Includes_Images.xml`, `Includes_Overlay.xml`, `Includes_DialogInfo.xml`, `Includes_Search.xml`, `Includes_Widgets.xml`, `Includes_Views_Combined.xml`, `Custom_1140_OSD_Playlist.xml`, and related surfaces — reconcile every hit with **D-038** (`Includes_Hubs.xml` is Velocity `list_id` wiring; audit separately).

---

## Work items

| ID | Work item | Implemented | Verified | Notes |
|----|-----------|-------------|----------|-------|
| D2.1 | Rename or neutralize `Window(home).property(tmdbhelper.userdiscover.folderpath)` in search/discover when product accepts breaking change (D-038 §4) | - [ ] | - [ ] | |
| D2.2 | Replace remaining `TMDbHelper.Player.CropImage` / `TMDbHelper.WidgetContainer` / `TMDbHelper.ListItem.*` per D-038 batches | - [ ] | - [ ] | Do not delete ledger rows without code change |
| D2.3 | Re-grep after each slice; ensure no **undeclared** helper refs in migrated surfaces | - [ ] | - [ ] | Link grep output or PR |
| D2.4 | Update D-038 + [LIST_IMPLEMENTATION_STATUS](./LIST_IMPLEMENTATION_STATUS.md) when list wiring changes | - [ ] | - [ ] | |

---

## Exit criteria

- [ ] Each remaining grep hit is either **removed** or **listed in D-038** with rationale
- [ ] D2.1–D2.4 rows updated; **Verified** means reviewed in Kodi where UI-visible
- [ ] [ROADMAP_MASTER](../ROADMAP_MASTER.md) Phase 2 row set to complete or explicitly deferred
