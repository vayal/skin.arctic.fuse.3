# Non-list surfaces — index

**Scope:** Product and implementation direction for **non-list** skin surfaces (details, OSD, context menus, removals, generator workflow, search chrome). **List feeds** (`list_id`, D-015) are **not** here — use the list triple:

| Role | Location |
|------|----------|
| Addon list theory | [../context/README.md](../context/README.md) → [LIST_ADDON_THEORY.md](../context/LIST_ADDON_THEORY.md) |
| List contract target | [LIST_CONTRACTS_TARGET.md](LIST_CONTRACTS_TARGET.md) |
| List as-built status | [../status/LIST_IMPLEMENTATION_STATUS.md](../status/LIST_IMPLEMENTATION_STATUS.md) |

## Guidelines (how to change the skin safely)

| Document | Contents |
|----------|----------|
| [nonlist-generator-workflow.md](../context/nonlist-generator-workflow.md) | Mandatory SkinVariables generator path (sources → regen → commit) |
| [nonlist-skin-file-index.md](../context/nonlist-skin-file-index.md) | Typical XML / JSON / generator paths by concern |

## Target (what non-list surfaces should do)

| Document | Contents |
|----------|----------|
| [nonlist-details-osd-context-target.md](nonlist-details-osd-context-target.md) | Details, context menu, OSD, playback overlays — product direction |
| [nonlist-removals-scope-target.md](nonlist-removals-scope-target.md) | Removals and simplifications; doc freeze pointers (D-003, D-021, D-038) |
| [nonlist-search-chrome-target.md](nonlist-search-chrome-target.md) | Search window / tabs — product vs generator compatibility |

## Status (checklists and as-built tracking)

| Document | Contents |
|----------|----------|
| [../status/nonlist-osd-playback-status.md](../status/nonlist-osd-playback-status.md) | OSD windows 1140 / 1141 / 1143, pause overlay, `Custom_1193` |
| [../status/nonlist-pvr-removal-status.md](../status/nonlist-pvr-removal-status.md) | PVR entry points and includes |
| [../status/nonlist-submenu-shortcut-editor-status.md](../status/nonlist-submenu-shortcut-editor-status.md) | Home submenu strip, `ActivateWindow(1115)` |
| [../status/nonlist-details-context-status.md](../status/nonlist-details-context-status.md) | D-021 context menu, details lean pass, D-038 grep |
| [../status/nonlist-nextaired-home-status.md](../status/nonlist-nextaired-home-status.md) | NextAired on Home policy |

**Hub / view-mode decisions:** [d003-view-mode-matrix.md](d003-view-mode-matrix.md) · **Legacy properties:** [../context/d038-legacy-properties-and-mapping.md](../context/d038-legacy-properties-and-mapping.md) · **Blueprint:** [skin-vision-blueprint-v1.md](skin-vision-blueprint-v1.md)

**Per-control surface inventory** (item-level `keep`/`remove` decisions, separate from this non-list contract set): [../context/surface-inventory-index.md](../context/surface-inventory-index.md).
