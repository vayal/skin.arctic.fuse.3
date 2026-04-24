# Kodi Skin Documentation

Comprehensive documentation for Kodi skin development, covering both general concepts and the Arctic Fuse 3 Velocity fork.

## Quick Navigation

### General Kodi Skin Development
- [Core Architecture](01_CORE_ARCHITECTURE.md) - Skin engine, lifecycle, layered approach
- [Components](02_CORE_COMPONENTS.md) - addon.xml, windows, includes, dialogs, OSD
- [Controls](03_CONTROLS.md) - Groups, lists, buttons, labels, images, textures
- [Variables & Includes](04_VARIABLES_INCLUDES.md) - Skin variables, resolution order
- [script.skinvariables](05_SKINVARIABLES_ADDON.md) - Generator addon deep dive
- [HomeSwitcher](06_HOMESWITCHER.md) - Hub switching system
- [Hubs](07_HUBS.md) - Hub architecture and widget types
- [View Modes](08_VIEW_MODES.md) - View mode types and enforcement
- [Best Practices](09_BEST_PRACTICES.md) - Golden rules, code style, testing
- [Development Environment](10_DEVELOPMENT_ENV.md) - Setup, tools, installation
- [Testing & Debugging](11_TESTING_DEBUGGING.md) - Logs, issues, solutions
- [Deployment](12_DEPLOYMENT.md) - Packaging, repository, versioning

### Arctic Fuse 3 Velocity Fork
- [Fork Overview](20_FORK_OVERVIEW.md) - Core objective, architecture, roadmap
- [D-003 View Mode Matrix](21_D003.md) - Surface decisions
- [D-015 Addon Contracts](22_D015.md) - Contract families
- [D-021 Context Menu](23_D021.md) - Policy and implementation
- [D-038 Legacy Ledger](24_D038.md) - Migration tracking
- [Generator Pipeline](25_GENERATOR.md) - Deep dive
- [Hub System](26_HUBS_DEEP.md) - Deep dive
- [Migration Journey](27_MIGRATION.md) - Phases 01-07
- [Implementation Paths](28_PATHS.md) - End-to-end journeys
- [Guidelines](29_GUIDELINES.md) - Golden rules, code style
- [Roadmap](30_ROADMAP.md) - Phase tracking

## Documentation Structure

```
doc/reference/
├── 00_README.md                    # This file (numbered series index)
├── 01_CORE_ARCHITECTURE.md         # General: skin engine, lifecycle
├── 02_CORE_COMPONENTS.md           # General: addon.xml, windows, includes
├── 03_CONTROLS.md                  # General: all control types
├── 04_VARIABLES_INCLUDES.md        # General: variables & includes
├── 05_SKINVARIABLES_ADDON.md       # General: script.skinvariables
├── 06_HOMESWITCHER.md              # General: HomeSwitcher system
├── 07_HUBS.md                      # General: hub architecture
├── 08_VIEW_MODES.md                # General: view modes
├── 09_BEST_PRACTICES.md            # General: best practices
├── 10_DEVELOPMENT_ENV.md           # General: dev environment
├── 11_TESTING_DEBUGGING.md         # General: testing & debugging
├── 12_DEPLOYMENT.md                # General: deployment
├── 20_FORK_OVERVIEW.md             # Fork: overview & architecture
├── 21_D003.md                      # Fork: view mode matrix
├── 22_D015.md                      # Fork: addon contracts
├── 23_D021.md                      # Fork: context menu policy
├── 24_D038.md                      # Fork: legacy ledger
├── 25_GENERATOR.md                 # Fork: generator pipeline
├── 26_HUBS_DEEP.md                 # Fork: hub system deep dive
├── 27_MIGRATION.md                 # Fork: migration journey
├── 28_PATHS.md                     # Fork: implementation paths
├── 29_GUIDELINES.md                # Fork: guidelines
├── 30_ROADMAP.md                   # Fork: roadmap
└── REFERENCE/                      # Quick reference sheets
    ├── CONTROLS.md                 # Control type cheat sheet
    ├── INFOLABELS.md               # Infolabel reference
    ├── EXPRESSIONS.md              # Common expressions
    └── CONTRACTS.md                # Velocity contracts
```

## How to Use

### For General Kodi Skin Development

1. **Start with** `01_CORE_ARCHITECTURE.md` to understand how Kodi skins work
2. **Learn components** in `02_CORE_COMPONENTS.md` and `03_CONTROLS.md`
3. **Master variables** in `04_VARIABLES_INCLUDES.md` and `05_SKINVARIABLES_ADDON.md`
4. **Understand hubs** in `06_HOMESWITCHER.md` and `07_HUBS.md`
5. **Apply best practices** from `09_BEST_PRACTICES.md`

### For Arctic Fuse 3 Velocity Fork

1. **Start with** `20_FORK_OVERVIEW.md` for the big picture
2. **Understand decisions** in `21_D003.md`, `22_D015.md`, `23_D021.md`, `24_D038.md`
3. **Learn the generator** in `25_GENERATOR.md`
4. **Follow migration** in `27_MIGRATION.md` and `28_PATHS.md`

### Quick Reference

See the `REFERENCE/` directory for quick lookup of:
- Control type attributes and common uses
- Infolabel expressions
- Common skin expressions
- Velocity addon contracts

---

*Last updated: 2026-04-22*