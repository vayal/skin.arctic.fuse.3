# Traceability Index

This index maps inventory docs to primary source files.

## Hierarchy docs -> source surfaces

- [`01-home-and-hubs.md`](./01-home-and-hubs.md)
  - `1080i/Home.xml`
  - `1080i/Includes_Home.xml`
  - `1080i/Includes_Hubs.xml`
  - `1080i/Includes_NextAired.xml`
- [`02-search-and-discovery.md`](./02-search-and-discovery.md)
  - `1080i/Includes_Search.xml`
  - `1080i/Custom_1105_Search.xml`
  - `shortcuts/generator/data/setup/search_path.xml`
  - `shortcuts/skinvariables-shortcut-searchwidgets.json`
- [`03-dialogs-info-and-context.md`](./03-dialogs-info-and-context.md)
  - `1080i/Dialog_DialogView.xml`
  - `1080i/Dialog_DialogPlot.xml`
  - `1080i/Dialog_DialogContextMenu.xml`
  - `1080i/Includes_DialogInfo.xml`
  - `1080i/Custom_1114_Dialog_CustomPlot.xml`
- [`04-osd-and-playback-surfaces.md`](./04-osd-and-playback-surfaces.md)
  - `1080i/Includes_OSD.xml`
  - `1080i/Custom_1140_OSD_Playlist.xml`
  - `1080i/Custom_1141_OSD_Cast.xml`
  - `1080i/Custom_1193_VideoOSDInfo.xml`
  - `1080i/Dialog_DialogPVRInfo.xml`
- [`05-settings-and-customization.md`](./05-settings-and-customization.md)
  - `1080i/Settings.xml`
  - `1080i/SkinSettings.xml`
  - `1080i/Includes_SkinSettings.xml`
  - `1080i/Custom_1115_Window_Shortcuts.xml`
  - `1080i/Dialog_DialogShortcuts.xml`
- [`06-actions-properties-and-background-contracts.md`](./06-actions-properties-and-background-contracts.md)
  - `1080i/Includes_Actions.xml`
  - `1080i/Includes_Paths.xml`
  - `1080i/Includes_Expressions.xml`
  - `1080i/Includes_Velocity_Paths.xml`
- [`07-shortcuts-generator-pipeline.md`](./07-shortcuts-generator-pipeline.md)
  - `shortcuts/skinvariables-generator.json`
  - `shortcuts/generator/data/base/*`
  - `shortcuts/generator/data/setup/*`
  - `shortcuts/generator/data/parts/*`

## Journey docs -> hierarchy anchors

- [`journeys/browse-to-play.md`](./journeys/browse-to-play.md) -> `home`, `hubs`, `osd`, `actions`
- [`journeys/search-to-play.md`](./journeys/search-to-play.md) -> `search`, `dialogs`, `osd`
- [`journeys/info-and-related.md`](./journeys/info-and-related.md) -> `dialogs`, `context`, `paths`
- [`journeys/settings-and-customize.md`](./journeys/settings-and-customize.md) -> `settings`, `shortcuts-generator`
