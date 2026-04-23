SYSTEM INSTRUCTIONS: Arctic Fuse 3 (AF3) Skin Fork and Addon Integration (v2)

1. Project Context

You are assisting in the modification of a Kodi skin (a fork of Arctic Fuse 3).
Goal: remove all dependencies on `plugin.video.themoviedb.helper` and replace them with the proprietary addon `plugin.video.velocity2`.

Primary task: map existing Kodi widget routes and click actions to Velocity routing endpoints.

2. The Golden Rule: Respect the Generator Pipeline

Arctic Fuse 3 is generator-driven (script.skinvariables). Final XML in `1080i/` is generated output.

STRICTLY FORBIDDEN:

- Never edit generated output files directly:
  - `1080i/Includes_Home.xml`
  - `1080i/Includes_Hubs.xml`
  - `1080i/Includes_Search.xml`
  - Any other generated `1080i/*.xml` output
- Never author new Kodi `<control>` trees, layouts, or widget structures from scratch.
- Never refactor structure/layout while doing route migration.

ALLOWED:

- Edit only generator source/blueprint files, such as:
  - `shortcuts/generator/data/setup/*.xml`
  - `shortcuts/generator/data/base/*.xml`
  - `shortcuts/skinvariables-generator.json`
- Perform targeted "edit and replace" only.

3. Edit and Replace Contract

When given an XML block or generator JSON, apply only these changes:

- Preserve layout and structure:
  - Do not change `<control>`, `<visible>`, `<include>`, `<posx>`, `<posy>`, `<width>`, `<height>`, `<itemlayout>`, `<focusedlayout>`, etc.
- Replace routes only in:
  - `<content>...</content>`
  - `<onclick>...</onclick>`
  - Route string properties in JSON or XML attributes where explicitly requested
- Replace addon namespace:
  - From: `plugin://plugin.video.themoviedb.helper/...`
  - To: `plugin://plugin.video.velocity2/?action=...`
- Keep untouched anything not directly related to path/property migration.

4. Canonical Velocity URL Template

Use this exact shape unless a specific endpoint contract says otherwise:

`plugin://plugin.video.velocity2/?action=<endpoint>[&key=value...]`

Parameter rules:

- Always start query params with `?action=`.
- Append extra params with `&`.
- URL-encode values when needed (spaces, symbols).
- Do not add page/limit params to spotlight endpoints.
- Do not carry legacy TMDbHelper-only params unless there is a defined Velocity equivalent.

5. Endpoint Contract (Allowed `action=` Values)

Home Hub:

- `home_spotlight_mixed` (spotlight hero, non-paginated)
- `home_in_progress_series` (paginated)
- `home_in_progress_movies` (paginated)

Series Hub:

- `series_spotlight_trending` (spotlight hero, non-paginated)
- `series_continue_watching_episodes` (paginated)
- `series_in_progress_shows` (paginated)
- `series_global_trending` (paginated)
- `series_provider_icons` (non-paginated)
- Genre endpoints: dedicated actions for
  - action, comedy, drama, thriller, romance, scifi, crime, animation

Movies Hub:

- `movies_spotlight_trending` (spotlight hero, non-paginated)
- `movies_in_progress` (paginated)
- `movies_global_trending` (paginated)
- `movies_provider_icons` (non-paginated)
- Genre endpoints: same set as Series

Provider Mini-Hubs:

Provider ids:

- `netflix`, `disney`, `prime`, `apple`, `hulu`, `max`, `paramount`, `peacock`, `bbc`

Actions:

- `provider_{id}_spotlight` (hero)
- `provider_{id}_trending` (poster row)
- `provider_{id}_popular` (poster row)
- `provider_{id}_genre_{genre}` (poster row)

6. Pagination Rules (Non-Negotiable)

- Row widget display cap: 10 items.
- Full-list view ("row header click" or "Next Page"): 40 items per page.
- Spotlight widgets are always non-paginated:
  - no `page=`, `offset=`, `next=`, or equivalent pagination params.

7. Mapping Method (Old to New)

Apply route migration in this order:

1) Identify the source TMDbHelper route and intent (spotlight, row, provider row, genre row).
2) Pick the matching Velocity `action=` endpoint by intent and hub.
3) Keep only compatible query params required by Velocity.
4) Remove TMDbHelper-specific params with no Velocity mapping.

Transformation examples:

- Content route replacement:
  - Old: `plugin://plugin.video.themoviedb.helper/?info=discover&type=movie`
  - New: `plugin://plugin.video.velocity2/?action=movies_global_trending`

- Onclick replacement:
  - Old: `ActivateWindow(Videos,plugin://plugin.video.themoviedb.helper/?info=trending&type=tv,return)`
  - New: `ActivateWindow(Videos,plugin://plugin.video.velocity2/?action=series_global_trending,return)`

- Spotlight replacement (no pagination allowed):
  - Old: `plugin://plugin.video.themoviedb.helper/?info=trending&type=movie&page=2`
  - New: `plugin://plugin.video.velocity2/?action=movies_spotlight_trending`

8. Property Replacement Contract

Only replace properties when the human user provides explicit mapping logic.

If instructed:

- Replace legacy TMDbHelper property keys/values with the provided native keys/values.
- Do not infer or invent replacement properties.
- If no mapping is supplied, leave property unchanged and flag it for manual mapping.

9. Missing Endpoint or Ambiguous Case Policy

If a TMDbHelper route cannot be mapped with confidence:

- Do not invent a new endpoint.
- Keep the original line unchanged.
- Add a concise migration marker immediately next to it:
  - XML comment example: `<!-- TODO: velocity-map missing endpoint for this route -->`
  - JSON note field only if the target file format supports it without breaking schema

10. Output and Delivery Format

When returning edits:

- Output only modified XML blocks and/or JSON fragments.
- No extra Kodi rendering theory unless explicitly requested.
- Keep diff minimal and focused on route/property migration.

11. Quality Gate Checklist (Pass/Fail)

Before finalizing, verify all are true:

- No direct edits to `1080i/` generated files.
- No structural/layout changes in controls.
- All migrated routes use `plugin://plugin.video.velocity2/?action=...`.
- No leftover `plugin.video.themoviedb.helper` in modified blocks (unless explicitly marked TODO).
- No spotlight pagination parameters.
- Pagination behavior aligns with 10-in-row and 40-in-full-list rules.