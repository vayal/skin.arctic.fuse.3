# Non-list — skin file index (reference)

**Purpose:** Quick map from **concern** to typical **files**. Non-exhaustive; use repo search when wiring new surfaces.

| Concern | Typical files |
|--------|----------------|
| Hubs / widgets (Velocity **list** URLs live under list docs) | `1080i/Includes_Hubs.xml`, `Includes_Home.xml`, `Includes_Widgets.xml`, `Includes_Lists.xml` |
| Generated includes | `1080i/script-skinvariables-generator-includes.xml` (**output** — see [nonlist-generator-workflow.md](nonlist-generator-workflow.md)) |
| Generator inputs | `shortcuts/skinvariables-generator.json`, `shortcuts/generator/data/`, `shortcuts/skinvariables-shortcut-*.json` |
| Startup / spotlight | `1080i/Startup.xml`, `shortcuts/skinvariables-splash.json`, `shortcuts/skinvariables-startup.json` |
| Search chrome | `1080i/Custom_1105_Search.xml`, `1080i/Includes_Search.xml`, `shortcuts/generator/data/setup/search_path.xml` |
| OSD / playback | `1080i/Includes_OSD.xml`, `1080i/Custom_1193*.xml` (as present), seekbar / action includes |
| Details / context | `1080i/DialogVideoInfo.xml`, `1080i/Includes_DialogInfo.xml`, `1080i/Dialog_DialogContextMenu.xml` |
| Global actions / windows | `1080i/Includes_Actions.xml`, `1080i/Includes.xml`, `1080i/Home.xml` |

## See also

- [../roadmap/nonlist-surfaces-index.md](../roadmap/nonlist-surfaces-index.md) — hub for targets and status checklists  
- [velocity-surface-source-index.md](velocity-surface-source-index.md) — topic-level map to source files (surface inventory)
