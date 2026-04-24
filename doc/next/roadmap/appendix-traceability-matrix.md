# Appendix - Traceability Matrix

This matrix links decision artifacts and migration batches to roadmap phases and primary touch files.

## 1) Decision-to-Phase Mapping

| Decision Artifact | Decision Scope | Roadmap Phase(s) | Primary References |
|---|---|---|---|
| `D-003` | view mode locking per surface | Phase 01, 05, 07 | [D-003](../../target/d003-view-mode-matrix.md), [Non-list hub](../../target/nonlist-surfaces-index.md) |
| `D-015` | addon list contract families | Phase 01, 02, 03, 07 | [LIST_CONTRACTS_TARGET](../../target/LIST_CONTRACTS_TARGET.md), [list status](../../status/LIST_IMPLEMENTATION_STATUS.md) |
| `D-021` | context menu policy | Phase 01, 04, 07 | [Blueprint](../../archive/skin-vision-blueprint-v0.md), [D-038](../../context/d038-legacy-properties-and-mapping.md) |
| `D-038` | legacy property migration ledger | Phase 01, 03, 04, 05, 06, 07 | [D-038](../../context/d038-legacy-properties-and-mapping.md) |

## 2) Ledger Batch-to-Phase Mapping

| D-038 Batch | Intent | Roadmap Phase | Primary Touch Files |
|---|---|---|---|
| Batch A | remove-first approved surfaces | Phase 04 | `Dialog_DialogContextMenu.xml`, `Custom_1141_OSD_Cast.xml`, `Dialog_DialogPVRInfo.xml`, `DialogPVR*`, `Settings.xml`, `Includes_SkinSettings.xml`, `script-wikipedia.xml`, `Custom_1120_Dialog_SelectCrew.xml`, `Custom_1118_Dialog_Settings.xml`, `Custom_1113_Dialog_Plot.xml` |
| Batch B | control-plane replacement | Phase 03 | `Includes_Paths.xml`, `Includes_Actions.xml`, `Includes_DialogInfo.xml`, `DialogVideoInfo.xml`, `Dialog_DialogPlot.xml`, `Custom_1114_Dialog_CustomPlot.xml`, `Custom_1193_VideoOSDInfo.xml`, `Includes_Search.xml`, `Custom_1105_Search.xml` |
| Batch B.1 | fork default IA bootstrap prerequisite corrective slice | Phase 03 | `shortcuts/skinvariables-startup.json`, `1080i/Home.xml`, `1080i/Includes_Home.xml`, `1080i/Includes_Hubs.xml` |
| Batch C | metadata/rendering replacement | Phase 05 | `Includes_Images.xml`, `Includes_Labels.xml`, `Includes_Info.xml`, `Includes_Overlay.xml`, `Includes_Views*`, `Includes_Widgets.xml`, `Includes_Lists.xml`, `Home.xml`, `Includes_Home.xml`, trailer/view/options/favourites/infooption dialogs |
| Batch D | deferred exceptions and residual cleanup | Phase 06 | `Custom_1105_Search.xml`, `Dialog_DialogWeather.xml`, `Includes_Weather.xml`, `Custom_1180_Dialog_Bumper.xml` (weather mini-flow may still exist; scope per D-038) |

## 3) Screen Contract-to-Phase Mapping

| Screen Contract Area | Roadmap Phase(s) | Source |
|---|---|---|
| Hub architecture and row definitions | Phase 01, 03, 05, 07 | [LIST_CONTRACTS_TARGET](../../target/LIST_CONTRACTS_TARGET.md) |
| Addon feed requirements | Phase 02, 03, 07 | [LIST_CONTRACTS_TARGET](../../target/LIST_CONTRACTS_TARGET.md), [addon theory](../../context/LIST_ADDON_THEORY.md) |
| Details/context/OSD behaviors | Phase 03, 04, 05, 07 | [Blueprint](../../archive/skin-vision-blueprint-v0.md), [nonlist details/OSD target](../../target/nonlist-details-osd-context-target.md), [OSD status](../../status/nonlist-osd-playback-status.md) |
| Removal/edit worklist | Phase 04, 06 | [nonlist removals target](../../target/nonlist-removals-scope-target.md), [D-038](../../context/d038-legacy-properties-and-mapping.md) |

## 4) Inventory Verification-to-Phase Mapping

| Inventory Area | Verification Use | Roadmap Phase(s) |
|---|---|---|
| [Inventory 01 Home and Hubs](../../status/surface-inventory-home-hubs.md) | hub row and mode verification | 03, 05, 07 |
| [Inventory 02 Search and Discovery](../../status/surface-inventory-search-discovery.md) | search/discovery behavior verification | 02, 03, 07 |
| [Inventory 03 Dialogs Info and Context](../../status/surface-inventory-dialogs-info-context.md) | details/context policy verification | 04, 05, 07 |
| [Inventory 04 OSD and Playback Surfaces](../../status/surface-inventory-osd-playback.md) | OSD policy and playback bridge verification | 03, 04, 07 |
| [Inventory 06 Actions Properties and Background](../../status/surface-inventory-actions-paths-background.md) | control-plane migration verification | 03, 05, 06 |
| [Browse to Play Journey](../../context/journeys/browse-to-play.md) | end-to-end browsing validation | 07 |
| [Search to Play Journey](../../context/journeys/search-to-play.md) | end-to-end search validation | 07 |
| [Info and Related Journey](../../context/journeys/info-and-related.md) | details/context validation | 07 |

## 5) Status Tracking Location

Phase execution status is tracked only in:

- [Roadmap README - Phase Status Tracking](./README.md)

## 6) Phase 02 Implementation Evidence

| Artifact | Purpose | Location |
|---|---|---|
| Phase 02 fixture source | addon-side contract-family sample payloads | `/home/mfuch/projects/plugin.video.velocity2_v2.dev/velocity_v2/plans/phase02-fixtures/contract-family-fixtures.json` |
| Phase 02 fixture mirror | skin-repo roadmap evidence pointer | [Phase 02 Fixture Mirror](./phase-02-fixtures-mirror.md) |

## 7) Phase 07 (active)

[phase-07-stabilization-and-freeze.md](./phase-07-stabilization-and-freeze.md) (**Validation status and blockers**). Decision closure for D-003 / D-015 / D-021 / D-038 is **pending** until runtime evidence is recorded there.

Phases 01–06 validation markdown reports were **removed** (2026-04-24); use git history if needed.

