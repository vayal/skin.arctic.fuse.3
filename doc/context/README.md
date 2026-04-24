# Context — Velocity skin fork

## What this repository is

- A **Kodi skin** (Arctic Fuse 3–derived) customized for **Velocity only** via `plugin://plugin.video.velocity2/?…`.
- **Not** the Velocity video addon: no Python addon code, daemon, or SQLite schema belongs here.

## Where “truth” lives

| Topic | Location |
|--------|-----------|
| Skin navigation & Velocity URL wrappers | `1080i/Includes_*.xml`, `1080i/Home.xml`, hub windows |
| Addon actions & `list_id` contracts | Addon repo `plans/velocity-addon-reference-for-skin-forks.md`; optional copy in this repo as `docs/VELOCITY_ADDON_REFERENCE.md` |
| Cursor agent rules | `.cursor/rules/*.mdc` |
| Human-readable product + delivery plan | [../README.md](../README.md) (this doc tree) → **Target** / **Next** |

## Conventions

- Prefer **one place** to change Velocity paths (wrapper includes), not scattered `plugin://` strings.
- Do not rely on TMDbHelper for **core** Velocity flows unless a compatibility shim is explicitly in scope.

## See also

- [Target / product specs](../target/README.md)
- [Reference / Kodi skin mechanics](../reference/README.md)
