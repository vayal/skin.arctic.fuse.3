# Kodi Skin Documentation

Numbered guides for **general** Kodi skin development (engine, controls, SkinVariables, hubs, view modes). These files live in **`doc/kodi/`** alongside this index.

**Velocity fork** (D-038, contracts, roadmap, surface inventory): **[`../velocity/README.md`](../velocity/README.md)**.

## Quick navigation — general Kodi skin development

- [Core Architecture](01_CORE_ARCHITECTURE.md) — Skin engine, lifecycle, layered approach
- [Components](02_CORE_COMPONENTS.md) — addon.xml, windows, includes, dialogs, OSD
- [Controls](03_CONTROLS.md) — Groups, lists, buttons, labels, images, textures
- [Variables & Includes](04_VARIABLES_INCLUDES.md) — Skin variables, resolution order
- [script.skinvariables](05_SKINVARIABLES_ADDON.md) — Generator addon deep dive
- [HomeSwitcher](06_HOMESWITCHER.md) — Hub switching system
- [Hubs](07_HUBS.md) — Hub architecture and widget types
- [View Modes](08_VIEW_MODES.md) — View mode types and enforcement
- [Best Practices](09_BEST_PRACTICES.md) — Golden rules, code style, testing
- [Development Environment](10_DEVELOPMENT_ENV.md) — Setup, tools, installation, log triage, packaging notes

Some “See also” links in older chapters may mention fork-only filenames (e.g. `26_HUBS_DEEP.md`) that are **not** in this folder — treat those as historical stubs and use **`../velocity/`** + **`../target/`** instead.

## How to use

1. Start with `01_CORE_ARCHITECTURE.md`.
2. Learn components in `02_CORE_COMPONENTS.md` and `03_CONTROLS.md`.
3. Master variables in `04_VARIABLES_INCLUDES.md` and `05_SKINVARIABLES_ADDON.md`.
4. Understand hubs in `06_HOMESWITCHER.md` and `07_HUBS.md`.
5. Apply `09_BEST_PRACTICES.md`.

---

*Index maintained for `skin.velocity.af3`; layout split 2026-04.*
