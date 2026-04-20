# Phase 02 Fixture Mirror

This file mirrors the addon-side Phase 02 sample payload fixtures for roadmap evidence.

Source fixture file:

- `/home/mfuch/projects/plugin.video.velocity_v2.dev/velocity_v2/plans/phase02-fixtures/contract-family-fixtures.json`

Contract families covered:

- Home contracts (`home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`)
- Series and Movies hub contracts
- Provider media-specific contract family (`provider_{provider_id}_{media}_*`)
- Global genre contract family (`genre_global_{genre}`)
- Search contracts (`search_movies`, `search_tvshows`) with params `query`, `media_type`, `page`, `sort`

Pagination fixture assertions included:

- paginated first-page fixture includes `items/page/has_more/next_page`
- terminal-page fixture omits `next_page`
- spotlight fixtures are non-paginated (`has_more=false`, no `next_page`)
