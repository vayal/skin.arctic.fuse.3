---
name: 01-route-migration
description: Standardized loop for moving from TMDbHelper to Velocity
---

# 01-route-migration

The primary workflow for migrating skin surfaces to the new backend.

## Usage
Use when tasked with "Updating a hub," "Fixing a widget," or "Migrating a screen."

## Steps
1. **Discovery:** Use `grep` to find legacy `plugin.video.themoviedb.helper` links in `shortcuts/generator/data/`.
2. **Consultation:** Search `velocity-addon-list-rails-report.md` for the matching Velocity `action`.
3. **Execution:** Update the XML/JSON blueprints with the new route.
4. **Validation:** Run the `02-build-and-verify` skill.
5. **Confirmation:** Confirm the `1080i/` XML now contains the Velocity string via `git diff`.