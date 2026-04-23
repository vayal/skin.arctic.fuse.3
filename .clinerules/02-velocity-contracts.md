# 2. Velocity Routing & DB Contracts

## Route Formatting
All new routes mapped to the skin must use this exact format:
`plugin://plugin.video.velocity/?action=<endpoint>[&key=value...]`

## Spotlight & Pagination Rules
- Spotlight feeds (e.g., `series_spotlight_trending`) are STRICTLY non-paginated. Never append `page=` or `next=` to them.
- Row-level paging caps at 10 items in-row, full list pages cap at 40.

## Database Integrity (WSL)
The Velocity SQLite database is located at:
`/home/mfuch/.var/app/tv.kodi.Kodi/data/userdata/addon_data/plugin.video.velocity2/velocity.db`
- If you are asked to debug missing UI items, use the `wsl-sqlite` MCP tool to run `SELECT` queries on the `catalog_list` and `list_item` tables to verify the data exists before assuming the XML is broken.