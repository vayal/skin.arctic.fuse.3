# Skin load & widget performance — re-analysis after spotlight changes

**Scope:** `skin.velocity.af3` + `plugin.video.velocity2` (Velocity) as wired on Home and hub windows.  
**Date:** 2026-04-23 (post–spotlight navigation / expression updates).

---

## 1. What changed in spotlight behavior (current code)

### 1.1 New expression: `Exp_Hubs_Spotlight_HasNonEmptyList`

**File:** `1080i/Includes_Expressions.xml`

- **`Exp_Hubs_Spotlight_HasItems`** (unchanged): true when container **301** has *either* real items *or* `Container(301).IsUpdating` (including the “0 items but still filling” phase).
- **`Exp_Hubs_Spotlight_HasNonEmptyList`** (new): true **only** when `Container(301).NumItems` is **not** zero — i.e. the spotlight plugin list has actually returned at least one row.

Inline comments document the motivation: using **`HasItems` alone for “Down → spotlight”** could be true while **301 is updating with 0 items**, in situations where the hero chrome does not align with focus expectations (`Hub_Spotlight_Visible_Expression` ties visibility to `Velocity.WidgetContainer == 301` plus items/updating). That produced **broken Down navigation** and a **“loading loop” feel** (user stuck or sent to an unusable spotlight strip).

### 1.2 Home menu Down: spotlight strip only after real list rows

**File:** `1080i/Includes_Home.xml` (`Home_Control`, button **300**)

Order of `ondown` handling is now:

1. **`Exp_Hubs_Spotlight_HasNonEmptyList`** + spotlight path configured → **`SetFocus(310)`** (grouplist with play/info chrome).
2. Else if widget **501** visible → **`SetFocus(501)`**.
3. Else if **301** visible → **`SetFocus(301)`** (hidden wraplist; legacy path).
4. Else refocus **300**.

**Effect:** While spotlight **301** is still **updating with zero items**, pressing **Down** from the main hub control **prefers the first visible widget row (501)** instead of forcing focus onto the spotlight chrome (**310**) that is not yet backed by real items. This is primarily a **UX / navigation** fix, not a reduction in backend work.

### 1.3 Unchanged spotlight-related pieces (still relevant to load)

| Piece | Role |
|--------|------|
| **`Hub_Spotlight_Visible_Expression`** (`Includes_Hubs.xml`) | Whole spotlight **group** visible when `Velocity.WidgetContainer == 301` and (non‑empty list **or** updating). |
| **Wraplist 301 `<visible>`** | Still **`Exp_Hubs_Spotlight_HasItems`** — list stays “logically active” during `IsUpdating` with 0 items. |
| **`skinvariables-splash.json` → `301Updating`** | Still true when **301** is updating **and** (empty or single “no results” placeholder). Startup splash **wait loop** still tracks **301** completion, not `HasNonEmptyList`. |
| **`Action_FirstStart_HomeFocus`** (`Includes_Actions.xml`) | Still **`SetFocus(310)`** whenever `HomeSwitcher.Home.Spotlight.Target` is non‑empty — **not** gated on `HasNonEmptyList`. First‑run focus can still land on spotlight chrome before rows exist (minor inconsistency with strict “non‑empty only” semantics). |
| **Widget rows `onup` → 310** (`script-skinvariables-generator-includes.xml`) | Still use **`Exp_Hubs_Spotlight_HasItems`** for jumping back to spotlight controls. |

---

## 2. Plugin / contract context (spotlight data, not skin focus)

**File:** `plugin.video.velocity2/lib/daemon/phase02_contracts.py`

- Spotlight feeder lists are **non‑paginated**, **hard‑capped** (`SPOTLIGHT_MAX_ITEMS = 20`, comment references D‑015 / skin hub wraplist **301**).
- Aligns daemon list shape with the skin’s **finite** hero list — avoids huge directories and “next page” in the hero.

This limits **per‑request work** for `action=list&list_id=…` spotlight feeds but does **not** remove: Python cold path, SQLite read, `build_list_item`, or **remote art URLs** when metadata only has TMDb paths.

---

## 3. Revised performance assessment (after spotlight changes)

### 3.1 What the spotlight change **does** improve

- **Perceived stall / broken flow** when the hero is still loading: users can **reach widgets** from the home control **without** requiring `HasItems` to imply a usable **310** focus target.
- **Clearer semantics** in expressions: “has rows” vs “has rows or is still fetching” are now explicit for **menu Down**.

### 3.2 What the spotlight change **does not** materially change

| Area | Why |
|------|-----|
| **Total `plugin://` invocations** | Wraplist **301** still loads the same spotlight URL; visibility during `IsUpdating` is unchanged. |
| **`skinvariables-splash.json` wait** | Still driven by **`301Updating`** / **`501Updating`** and hub preload rules — not switched to `HasNonEmptyList`. |
| **Skin XML size / include graph** | Unchanged (~42k lines under `1080i/`, heavy `Includes.xml` chain). |
| **Parallel smart rails + spotlight `list`** | Home still combines spotlight **`action=list`** with multiple **`action=smart_list`** rows in standard/wall/combined layouts. |
| **Artwork latency** | List items still often carry **`https://image.tmdb.org/...`** when only path fields exist in metadata (`lib/rails/common.py`, `lib/client/builder.py`) — Kodi texture pipeline remains **network‑sensitive**. |
| **HTTP fallback timeouts** | `handle_list` / smart list fallback still use **long HTTP timeouts** (e.g. 60s class) if DB/daemon path fails — can dominate wall clock when misconfigured. |

So: **long cold startup (minutes)** should **not** be expected to disappear solely from this spotlight patch; it mainly fixes **focus / Down behavior** during the loading window.

---

## 4. Dominant remaining causes of slow skin / widget load

Ordered by typical impact (same as pre–spotlight analysis, still valid):

1. **Startup splash + optional hub preload** (`shortcuts/skinvariables-splash.json` + `Startup.DisableWaitForLoad` / `Startup.EnableHubPreloading` in skin settings). Serial hub activation + **polling** until **301** and **501** leave “updating/empty” states.
2. **Many directory listings** on Home (spotlight + 2+ visible smart rails; more in Wall/Combined; hidden rows may still be scheduled depending on Kodi build).
3. **Daemon / DB readiness** — each handler may wait briefly for DB then fall back to **HTTP** with large timeouts.
4. **Remote poster/fanart** resolution for many tiles.
5. **Skin parse cost** — large always‑included XML set.

---

## 5. Optional follow-ups (not implemented here)

- Align **`Action_FirstStart_HomeFocus`** with **`Exp_Hubs_Spotlight_HasNonEmptyList`** (or `Control.IsVisible(310)` with stricter rules) so first boot does not focus **310** before rows exist.
- Consider whether **`skinvariables-splash.json`** should treat spotlight as “ready” using **`HasNonEmptyList`** (or shorter timeouts) instead of/in addition to **`301Updating`**, if the goal is to dismiss splash when widgets are usable rather than when **301** stops updating.
- **Skin settings:** `Startup.DisableWaitForLoad` / disable hub preload — fastest way to validate splash contribution in the field.

---

## 6. Key file references

| Topic | Location |
|--------|-----------|
| Non‑empty vs has‑items expressions | `1080i/Includes_Expressions.xml` (`Exp_Hubs_Spotlight_HasItems`, `Exp_Hubs_Spotlight_HasNonEmptyList`) |
| Home Down / spotlight vs widgets | `1080i/Includes_Home.xml` (`Home_Control` `ondown`) |
| Spotlight layout, visibility, wraplist 301 | `1080i/Includes_Hubs.xml` (`Hub_Spotlight`, `Hub_Spotlight_List`, `Hub_Spotlight_Visible_Expression`) |
| First‑start focus | `1080i/Includes_Actions.xml` (`Action_FirstStart_HomeFocus`) |
| Splash / preload / 301Updating | `shortcuts/skinvariables-splash.json` |
| Startup alarm / splash properties | `1080i/Startup.xml`, `1080i/Custom_1198_Dialog_Startup.xml` |
| Spotlight list cap / no pagination | `plugin.video.velocity2/lib/daemon/phase02_contracts.py` (`SPOTLIGHT_MAX_ITEMS`, `_non_paginated_spotlight`) |

---

## 7. Conclusion

The **recent spotlight work** is a **navigation and state‑expression correction**: it prevents treating “**301 updating with zero items**” as equivalent to “**user should jump to spotlight chrome via Down**.” It does **not** remove the underlying costs of **multiple plugin lists**, **splash gating**, **large skin XML**, or **remote artwork**.

For **end‑to‑end load time**, continue to prioritize: **startup splash settings**, **hub preload**, **daemon+DB health**, **local/cached art URLs**, and **number of concurrent `plugin://` containers** on Home.
