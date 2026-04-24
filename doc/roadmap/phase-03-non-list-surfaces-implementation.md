# Phase 3 — Non-list surfaces implementation

**Parent:** [ROADMAP_MASTER.md](../ROADMAP_MASTER.md)
**Template:** [PHASE_TEMPLATE.md](./PHASE_TEMPLATE.md)

## Phase metadata

| Field | Value |
|-------|-------|
| Phase status | planned |
| Owner | TBD |
| Last updated | 2026-04-24 |
| In scope | Details/context, OSD/playback chrome, search chrome, removals, inventory decisions |
| Out of scope | Freeze closure evidence and post-freeze debt-only cleanup |

## Objective

Convert non-list roadmap intent into concrete implementation decisions and executable tasks, with every high-impact surface resolved to keep/remove/defer.

## Inputs / references

- [Phase 1](./phase-01-contract-and-ia-baseline.md)
- [Phase 2](./phase-02-list-implementation-alignment.md)
- [Phase 4](./phase-04-freeze-and-runtime-verification.md)
- [Phase 5](./phase-05-debt-cleanup-and-policy-closure.md)
- [D-038 ledger](../context/d038-legacy-properties-and-mapping.md)
- [traceability-by-topic.md](../traceability-by-topic.md)

## Non-list target baseline to implement

- Info action resolves to full details (no small-popup fallback).
- Details rails stay lean and Velocity-first.
- Expanded context menu is curated by D-021 keep/remove policy.
- OSD target is minimal control scope plus controlled overlay -> full details transition.
- Search chrome target is Discover/Movies/TV with Velocity `execute_search` path model.
- Removals/simplifications include non-primary NextAired home role, submenu/editor policy, and PVR/legacy helper cleanup path.

## Surface decision backlog (must become actionable)

| Cluster | High-impact items to resolve | Decision required |
|--------|-------------------------------|------------------|
| Home/hubs non-list control plane | `home-root-window`, `home-switcher-shortcuts`, `home-submenu-staticitems`, `nextaired-home-rails` | keep/remove/defer |
| Search/discovery | `search-window-entry`, `search-selector-menu`, `search-alias-resolution`, `search-discover-contract` | keep/simplify/deprecate |
| Dialogs and context | `dialog-info-main`, `dialog-contextmenu-expanded`, `dialog-plot-custom`, `dialog-person-and-crew-rails` | retain/slim/remove |
| OSD/playback | `osd-main-controls`, `osd-playlist-dialog`, `osd-cast-dialog`, `osd-info-bridge`, `osd-next-recommendation` | retain/disable/remove |
| Settings/customization | `settings-shortcut-editor-flow`, `settings-legacy-helper-entries` | public/dev-only/remove |
| Actions/paths/contracts | `velocity-path-wrapper-contracts`, `global-path-variable-layer`, `legacy-helper-property-model` | freeze/replace/defer |
| Generator pipeline | `generator-root-config`, `generator-setup-transform-rules`, `search-widget-alias-family` | align and regenerate |

## Work items

| ID | Work item | Implemented | Verified | Evidence / notes |
|----|-----------|-------------|----------|------------------|
| P3.1 | Freeze non-list target policy for details/context/OSD/search/removals | - [ ] | - [ ] | |
| P3.2 | Resolve D-021 context menu keep/remove decisions | - [ ] | - [ ] | |
| P3.3 | Resolve OSD windows policy for 1140/1141/1143 and bridge flow | - [ ] | - [ ] | |
| P3.4 | Resolve search chrome tab/alias policy and generator mapping | - [ ] | - [ ] | |
| P3.5 | Resolve home submenu + shortcut editor policy (public vs dev-only) | - [ ] | - [ ] | |
| P3.6 | Resolve NextAired home placement policy and implementation | - [ ] | - [ ] | |
| P3.7 | Convert inventory `undecided` items to explicit decisions | - [ ] | - [ ] | |
| P3.8 | Link all deferred helper-dependent items to D-038 or Phase 5 | - [ ] | - [ ] | |

## Execution checklist

### Details / context

- [ ] Apply D-021 decision table in `Dialog_DialogContextMenu.xml`
- [ ] Perform lean pass on details surfaces (`DialogVideoInfo.xml`, `Includes_DialogInfo.xml`)
- [ ] Document retained advanced surfaces and rationale

### OSD / playback

- [ ] Decide and implement policy for `1140`, `1141`, `1143`
- [ ] Align `Custom_1193_VideoOSDInfo.xml` with overlay -> full-details target
- [ ] Verify playback continuity after closing full details

### Search / discovery

- [ ] Confirm shipped tabs and copy align with Discover/Movies/TV policy
- [ ] Remove or gate music/legacy alias families in search generator sources
- [ ] Regenerate and verify search includes

### Removals and policy

- [ ] Enforce NextAired not being primary Home rail (unless explicitly accepted)
- [ ] Decide submenu static strip and shortcut editor user access policy
- [ ] Map PVR entry points and flag for final policy closure in Phase 5

### Inventory governance

- [ ] Mark each high-impact inventory item as keep/remove/defer
- [ ] Add owner and implementation slice link for each non-deferred item
- [ ] Add deferred reason and target phase for each deferred item

## Verification checklist

- [ ] No high-impact inventory item remains `undecided`
- [ ] Non-list checklists are complete and evidence-linked
- [ ] D-021 decisions are reflected in code and docs
- [ ] D-038 exceptions match current non-list behavior
- [ ] Phase 4 receives runtime test-ready verification list

## Blockers / risks

- High-coupling includes can regress unrelated UX if changed without slice isolation.
- Generator compatibility can conflict with product simplification unless policies are explicit.
- Unresolved inventory decisions can block both freeze and debt-closure phases.

## Exit criteria

- [ ] P3.1-P3.8 complete and evidence-linked
- [ ] High-impact non-list inventory has no undecided items
- [ ] Deferred items are explicitly routed to Phase 5 with rationale
- [ ] Runtime verification package is ready for Phase 4

## Handoff

Update [ROADMAP_MASTER.md](../ROADMAP_MASTER.md) with Phase 3 status, route runtime checks to [Phase 4](./phase-04-freeze-and-runtime-verification.md), and route deferred debt/policy items to [Phase 5](./phase-05-debt-cleanup-and-policy-closure.md).

