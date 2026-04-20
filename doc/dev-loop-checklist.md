# Kodi Skin Dev Loop Checklist (Flatpak + WSL)

Use this loop for every skin change so testing stays fast and consistent.

## 0) One-time setup

- Skin source repo: `/home/mfuch/projects/skin.arctic.fuse.3`
- Kodi Flatpak addons dir: `/home/mfuch/.var/app/tv.kodi.Kodi/data/addons`
- Symlink must exist:
  - `skin.velocity.af3 -> /home/mfuch/projects/skin.arctic.fuse.3`

Verify:

```bash
ls -la "/home/mfuch/.var/app/tv.kodi.Kodi/data/addons/skin.velocity.af3"
readlink -f "/home/mfuch/.var/app/tv.kodi.Kodi/data/addons/skin.velocity.af3"
```

## 1) Edit

- Make XML/include/string changes in this repo.
- Keep Velocity routes centralized (wrapper includes), avoid scattered hardcoded plugin paths.

## 2) Reload in Kodi

- In Kodi, trigger `ReloadSkin()` after saving changes.
- If visual state looks stale, switch to another skin and back, then reload again.

## 3) Quick smoke test

- Home loads without layout errors.
- At least one widget opens and renders items.
- Spotlight/hero renders and focus navigation works (left/right/up/down/back).
- Open one details page and confirm text/art alignment.
- Start one playable item path and back out cleanly.

## 4) If something breaks

- Check Kodi log: `/home/mfuch/.var/app/tv.kodi.Kodi/data/temp/kodi.log`
- Search for likely errors:

```bash
rg -n "ERROR|WARNING|skin|xml" "/home/mfuch/.var/app/tv.kodi.Kodi/data/temp/kodi.log"
```

## 5) Before committing

- Re-run smoke test after final reload.
- Confirm no accidental dependency reintroduction (for this fork):

```bash
rg -n "plugin.video.themoviedb.helper|script.extendedinfo" "/home/mfuch/projects/skin.arctic.fuse.3"
```

