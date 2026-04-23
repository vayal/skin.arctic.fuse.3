---
name: 01-sqlite-validation
description: Validates if media metadata or lists actually exist in the Velocity backend DB
---

# 01-sqlite-validation

This skill allows the agent to verify if a UI "empty state" is caused by a skin bug or a missing database entry.

## Usage
Use this skill when a widget renders as "No items available" or when verifying if the `seed_genre_lists()` function worked.

## Steps
1. Identify the `list_id` being requested in the Skin XML.
2. Use the `wsl-sqlite` tool to query the `catalog_list` table for that ID.
3. Query `SELECT count(*) FROM list_item WHERE list_id = 'TARGET_ID';` to check item counts.
4. If the count is 0, notify the user that the backend requires seeding.