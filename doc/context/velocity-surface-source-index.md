# Velocity surface source index (traceability)

Maps **surface inventory** topics to primary skin source files. **Hub:** [Surface inventory index](./surface-inventory-index.md).

## Hierarchy inventories → source surfaces

- [surface-inventory-home-hubs](../roadmap/phase-03-non-list-surfaces-implementation.md)
  - `1080i/Home.xml`
  - `1080i/Includes_Home.xml`
  - `1080i/Includes_Hubs.xml`
  - `1080i/Includes_NextAired.xml`
- [surface-inventory-search-discovery](../roadmap/phase-03-non-list-surfaces-implementation.md)
  - `1080i/Includes_Search.xml`
  - `1080i/Custom_1105_Search.xml`
  - `shortcuts/generator/data/setup/search_path.xml`
  - `shortcuts/skinvariables-shortcut-searchwidgets.json`
- [surface-inventory-dialogs-info-context](../roadmap/phase-03-non-list-surfaces-implementation.md)
  - `1080i/Dialog_DialogView.xml`
  - `1080i/Dialog_DialogPlot.xml`
  - `1080i/Dialog_DialogContextMenu.xml`
  - `1080i/Includes_DialogInfo.xml`
  - `1080i/Custom_1114_Dialog_CustomPlot.xml`
- [surface-inventory-osd-playback](../roadmap/phase-03-non-list-surfaces-implementation.md)
  - `1080i/Includes_OSD.xml`
  - `1080i/Custom_1140_OSD_Playlist.xml`
  - `1080i/Custom_1141_OSD_Cast.xml`
  - `1080i/Custom_1193_VideoOSDInfo.xml`
  - `1080i/Dialog_DialogPVRInfo.xml`
- [surface-inventory-settings-customization](../roadmap/phase-03-non-list-surfaces-implementation.md)
  - `1080i/Settings.xml`
  - `1080i/SkinSettings.xml`
  - `1080i/Includes_SkinSettings.xml`
  - `1080i/Custom_1115_Window_Shortcuts.xml`
  - `1080i/Dialog_DialogShortcuts.xml`
- [surface-inventory-actions-paths-background](../roadmap/phase-03-non-list-surfaces-implementation.md)
  - `1080i/Includes_Actions.xml`
  - `1080i/Includes_Paths.xml`
  - `1080i/Includes_Expressions.xml`
  - `1080i/Includes_Velocity_Paths.xml`
- [surface-inventory-shortcuts-generator](../roadmap/phase-03-non-list-surfaces-implementation.md)
  - `shortcuts/skinvariables-generator.json`
  - `shortcuts/generator/data/base/*`
  - `shortcuts/generator/data/setup/*`
  - `shortcuts/generator/data/parts/*`

## Journey docs → hierarchy anchors

Journeys remain under `d./journeys/`.

- [`journeys/browse-to-play.md`](./journeys/browse-to-play.md) → `home`, `hubs`, `osd`, `actions`
- [`journeys/search-to-play.md`](./journeys/search-to-play.md) → `search`, `dialogs`, `osd`
- [`journeys/info-and-related.md`](./journeys/info-and-related.md) → `dialogs`, `context`, `paths`
- [`journeys/settings-and-customize.md`](./journeys/settings-and-customize.md) → `settings`, `shortcuts-generator`
