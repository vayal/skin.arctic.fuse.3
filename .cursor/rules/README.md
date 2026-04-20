# Cursor rules pack — Velocity skin fork

## Dedicated project (Cursor perspective)

**Yes:** keep the **skin fork in its own repository** (separate from `plugin.video.velocity2`).

- **Velocity addon repo:** Python, daemon, SQLite, tests — ship the video plugin + service.
- **Skin fork repo:** Kodi XML, textures, language strings — version with the skin upstream (AF3), not with Velocity releases.

That split matches how Cursor and git work: correct `.gitignore`, focused rules, agents do not confuse Python with XML, and you can open **two workspaces** or a multi-root workspace when you need both.

## Install these rules in the skin repo

1. Copy this entire **`cursor-rules-for-skin-fork`** folder’s **`.cursor`** directory into the **root** of your skin project, **or** copy only the files inside **`.cursor/rules/`** into an existing `<skin-repo>/.cursor/rules/` folder.

   Result on the skin repo:

   ```text
   <skin-repo>/
     .cursor/
       rules/
         velocity-skin-project.mdc
         kodi-skin-xml.mdc
         velocity-plugin-contracts.mdc
   ```

2. Optional: copy [`../velocity-addon-reference-for-skin-forks.md`](../velocity-addon-reference-for-skin-forks.md) into the skin repo as `docs/VELOCITY_ADDON_REFERENCE.md` (or submodule the addon repo) so agents always have plugin URLs and API tables offline.

3. Reload Cursor or open a new chat so rules apply.

## Editing rules

Rules use `.mdc` with YAML frontmatter — see [Cursor: Rules](https://docs.cursor.com/context/rules). Adjust `globs` if your skin uses different layout (e.g. all XML under `1080i/` only).
