# Arctic Fuse 3 (AF3) Skin Fork & Velocity Addon Migration

## Project Overview

This is a Kodi skin fork of Arctic Fuse 3, modified to completely strip out dependencies on `plugin.video.themoviedb.helper` addon and replace them with a proprietary custom addon called **Velocity** (`plugin.video.velocity2`).

## Core Objective

**Replace TMDbHelper with Velocity** - Map Kodi GUI widget pathways to Velocity's routing endpoints while preserving the skin's dynamic generation architecture driven by `script.skinvariables`.

## Key Constraints (The Golden Rules)

1. **NEVER edit output XML files** (`Includes_Home.xml`, `Includes_Hubs.xml`, `Includes_Search.xml`) - they are overwritten by the generator
2. **NEVER write Kodi `<control>` XML from scratch** - you will hallucinate syntax
3. **ONLY edit blueprint/shortcut files** (`shortcuts/generator/data/setup/*.xml`, `shortcuts/generator/data/base/*.xml`, `shortcuts/skinvariables-generator.json`)
4. **Edit & Replace strategy** - preserve layout tags, only replace `<content>` and `<onclick>` paths

## Architecture

- **Dynamic skin generation** via `script.skinvariables` addon
- **Blueprint files** define the UI structure
- **Velocity addon** provides the data contracts (D-015)
- **Generator pipeline** produces final XML from blueprints + addon data

## Roadmap Status

- **Phase 01-06**: Completed (preflight, addon contracts, core plumbing, removals, metadata migration, cleanup)
- **Phase 07**: Blocked - requires Kodi runtime evidence for end-to-end journeys

## Critical Decisions (Frozen)

| ID | Scope | Status |
|---|---|---|
| D-003 | View mode matrix per surface | Frozen |
| D-015 | Addon list contract families | Frozen |
| D-021 | Context menu policy | Frozen |
| D-038 | Legacy property migration ledger | Frozen |

## Primary Touch Files

- `1080i/Includes_Paths.xml` - Path contract variables
- `1080i/Includes_Actions.xml` - Action dispatch
- `1080i/Includes_Home.xml` - Home switcher & hub rows
- `1080i/Includes_Hubs.xml` - Hub widget definitions
- `1080i/Custom_1105_Search.xml` - Search window (temporary helper key retained)

## Velocity Endpoint Contract Summary

**Home Hub**: `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`

**Series Hub**: `series_spotlight_trending`, `series_continue_watching_episodes`, `series_in_progress_shows`, `series_global_trending`, `series_provider_icons`

**Movies Hub**: `movies_spotlight_trending`, `movies_in_progress`, `movies_global_trending`, `movies_provider_icons`

**Provider Mini-Hubs**: `provider_{id}_spotlight`, `provider_{id}_trending`, `provider_{id}_popular`, `provider_{id}_genre_{genre}`

**Pagination**: In-row max 10 items, full list 40/page, spotlights non-paginated

## Current Blockers

- Phase 07 requires live Kodi runtime evidence for browse-to-play, search-to-play, and info journeys
- No Kodi execution environment available in CI/agent pipelines