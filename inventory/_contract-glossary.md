# Contract Glossary

## Path contract

A navigable content path (for example `plugin://...` or `videodb://...`) consumed by a container or action.

## Action contract

A trigger command (`RunPlugin`, `RunScript`, `ActivateWindow`, `PlayMedia`, `SetProperty`, etc.) that changes state or opens content.

## Property contract

A `Window(...).Property(...)` or `Skin.String(...)` key used as runtime state between surfaces.

## Setting contract

A persisted skin-level or addon-level preference (`Skin.HasSetting`, `Skin.SetString`, addon settings entry points).

## Generator contract

A source rule or template in `shortcuts/generator/*` that emits runtime includes used by the skin.

## Dependency types

- `velocity`: depends on `plugin.video.velocity2` contracts.
- `kodi-native`: uses Kodi core windows/actions/content.
- `legacy-helper`: tied to legacy helper contracts.
- `mixed`: combines more than one dependency family.
