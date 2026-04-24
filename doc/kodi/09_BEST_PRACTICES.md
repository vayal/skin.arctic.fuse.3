# Kodi Skin Development Best Practices

## Overview

Best practices for Kodi skin development ensure maintainable, performant, and user-friendly skins. This guide covers architecture, coding, testing, and deployment.

---

## 1. Architecture Best Practices

### Modular Design

1. **Use includes for reusable code** - Define common control groups in includes
2. **Separate concerns** - Keep window files focused on a single purpose
3. **Use override files** - Override default includes with custom ones
4. **Document dependencies** - Keep track of which includes depend on which

### HomeSwitcher Design

1. **Use hub toggle variables** - Track which hub is active
2. **Reset on navigation** - Clear stale state when switching hubs
3. **Use loop back** - Implement loop back for infinite scrolling
4. **Defer loading** - Load widgets only when needed

### View Mode Design

1. **Always enforce view mode** - Use `<view mode="...">` in all list controls
2. **Use item dimensions** - Set `itemheight` and `itemwidth` explicitly
3. **Use visibility conditions** - Hide inactive view modes
4. **Use view mode switching** - Switch view modes based on widget type

---

## 2. Coding Best Practices

### XML Structure

1. **Use consistent indentation** - 2 spaces for nested elements
2. **Use descriptive IDs** - Follow the `1000` base convention
3. **Use comments** - Document complex sections
4. **Avoid duplicate code** - Use includes for reusable patterns

```xml
<!-- Good -->
<control type="group" id="1001">
  <visible>IsVisible(HomeSwitcher.Home.Spotlight)</visible>
  <control type="list" id="1002">
    <label>Spotlight</label>
    <item>
      <label>$INFO[ListItem.Title]</label>
    </item>
  </control>
</control>

<!-- Bad -->
<control type="group" id="1001">
  <visible>IsVisible(HomeSwitcher.Home.Spotlight)</visible>
  <control type="list" id="1002">
    <label>Spotlight</label>
    <item>
      <label>$INFO[ListItem.Title]</label>
    </item>
    <item>
      <label>$INFO[ListItem.Title]</label>
    </item>
  </control>
</control>
```

### Variables

1. **Use descriptive names** - Follow the `[Category].[Subcategory].[Item].[Property]` convention
2. **Avoid circular dependencies** - Ensure variables don't reference each other in a loop
3. **Use self-referencing for dynamic lists** - Common in HomeSwitcher for dynamic content
4. **Reset variables when needed** - Use `Skin.Reset()` to clear stale values

```xml
<!-- Good -->
<variable name="HomeSwitcher.Home.Spotlight.List" 
  value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />

<!-- Bad -->
<variable name="HomeSwitcher.Home.Spotlight.List" 
  value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />
```

### Includes

1. **Organize by function** - Group related includes together
2. **Use override files for customizations** - Don't modify core includes directly
3. **Document dependencies** - Keep track of which includes depend on which
4. **Avoid deep nesting** - Keep include chains short and manageable

```xml
<!-- Good -->
<include name="Includes_Home.xml" />
<include name="Includes_Hubs.xml" />

<!-- Bad -->
<include name="Includes_Home.xml" />
<include name="Includes_Hubs.xml" />
<include name="Includes_Buttons.xml" />
<include name="Includes_Labels.xml" />
<include name="Includes_Images.xml" />
```

---

## 3. Performance Best Practices

### Widget Rendering

1. **Defer loading** - Load widgets only when needed
2. **Cache data** - Cache contract data to reduce API calls
3. **Batch requests** - Batch contract requests when possible
4. **Use view mode enforcement** - Ensure correct view mode to reduce rendering overhead

### HomeSwitcher Performance

1. **Use hub toggle variables** - Track which hub is active to avoid redundant rendering
2. **Reset on navigation** - Clear stale state when switching hubs to avoid memory leaks
3. **Use loop back** - Implement loop back for infinite scrolling to avoid boundary checks
4. **Defer loading** - Load widgets only when needed to reduce initial load time

### View Mode Performance

1. **Always enforce view mode** - Use `<view mode="...">` in all list controls to avoid recalculation
2. **Use item dimensions** - Set `itemheight` and `itemwidth` explicitly to avoid recalculation
3. **Use visibility conditions** - Hide inactive view modes to reduce rendering overhead
4. **Use view mode switching** - Switch view modes based on widget type to avoid recalculation

---

## 4. Testing Best Practices

### Unit Testing

1. **Test individual controls** - Test each control type separately
2. **Test variables** - Test variable resolution and evaluation
3. **Test includes** - Test include resolution and nesting
4. **Test view modes** - Test view mode enforcement and switching

### Integration Testing

1. **Test hub switching** - Test navigation between hubs
2. **Test widget rendering** - Test widget rendering in different view modes
3. **Test contract data** - Test contract data fetching and rendering
4. **Test pagination** - Test pagination and infinite scrolling

### User Testing

1. **Test navigation** - Test navigation between hubs and views
2. **Test search** - Test search functionality
3. **Test settings** - Test settings and preferences
4. **Test accessibility** - Test keyboard and remote control navigation

---

## 5. Debugging Best Practices

### Common Issues

| Issue | Cause | Solution |
|---|---|---|
| Content not displaying | View mode not enforced | Add `<view mode="...">` |
| Wrong item dimensions | Item dimensions not set | Set `itemheight` and `itemwidth` |
| Horizontal scrolling issues | Row view not enforced | Use `<view mode="row">` |
| Grid layout issues | Wall view not enforced | Use `<view mode="wall">` |
| Hero content not full screen | Spotlight view not enforced | Use `<view mode="spotlight">` |

### Debugging Tools

1. **Kodi debug mode** - Enable debug mode in Kodi settings
2. **Log files** - Check Kodi log files for errors
3. **Velocity debug** - Use Velocity addon debug mode
4. **Skin variables debug** - Use script.skinvariables debug mode

### Debugging Patterns

```xml
<!-- Debug view mode -->
<visible>
  <or>
    <condition expression="IsVisible(HomeSwitcher.Home.Spotlight)" />
    <condition expression="IsVisible(HomeSwitcher.Home.ContinueWatching)" />
  </or>
</visible>
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>
```

---

## 6. Deployment Best Practices

### Version Control

1. **Use descriptive commit messages** - Follow conventional commit format
2. **Branch for features** - Use feature branches for new functionality
3. **Tag releases** - Tag releases with semantic versioning
4. **Document changes** - Update changelog for each release

### Release Process

1. **Test in Kodi** - Always test changes in Kodi before release
2. **Document breaking changes** - Clearly document breaking changes
3. **Provide migration guide** - Provide migration guide for major changes
4. **Backport fixes** - Backport critical fixes to previous versions

### Documentation

1. **Document architecture** - Document skin architecture and design
2. **Document API** - Document skin API and contracts
3. **Document conventions** - Document naming and coding conventions
4. **Document troubleshooting** - Document common issues and solutions

---

## 7. Common Patterns

### Hub Switching

```xml
<!-- In Home.xml -->
<visible>
  <or>
    <condition expression="!Skin.HasSetting(HomeSwitcher.DisableSearch)" />
    <condition expression="IsVisible(HomeSwitcher.Home.InProgress)" />
  </or>
</visible>
```

### Widget List

```xml
<!-- In Includes_Hubs.xml -->
<include name="Includes_Hubs.xml">
  <variable name="HomeSwitcher.Home.Spotlight.List" 
    value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />
</include>
```

### View Mode Enforcement

```xml
<!-- In Includes_Views.xml -->
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>
```

---

## 8. Golden rules (XML and generator discipline)

*Merged from the former `KODI_SKINS_DEEP_DOCUMENTATION.md` (2026-04).*

1. **Do not invent `<control>` XML from scratch** — copy patterns from this skin or upstream; Kodi control XML is easy to get subtly wrong.
2. **Prefer includes and variables** over pasting long `plugin://` strings in many places.
3. **URL-encode** query parameters in addon URLs where required.
4. **Respect the generator** — `script.skinvariables` output can be overwritten; change shortcuts / overrides / blueprints, not generated blobs.
5. **Edit-and-replace** — when swapping integrations, keep layout/focus IDs stable; change `<content>`, `<onclick>`, and visibility as needed.
6. **Native infolabels first** — `ListItem.*`, `Container.*`, `VideoPlayer.*` before helper-era properties.
7. **Document exceptions** — any remaining non-native binding belongs in `doc/velocity/d038-legacy-property-ledger.md`.

---

## 9. Quick Reference

### Do's

- [ ] Use includes for reusable code
- [ ] Enforce view mode in all list controls
- [ ] Use descriptive variable names
- [ ] Document dependencies
- [ ] Test in Kodi before release
- [ ] Use hub toggle variables
- [ ] Reset on navigation
- [ ] Use loop back for infinite scrolling

### Don'ts

- [ ] Don't duplicate code
- [ ] Don't skip view mode enforcement
- [ ] Don't use vague variable names
- [ ] Don't ignore Kodi logs
- [ ] Don't release without testing
- [ ] Don't forget to reset state
- [ ] Don't ignore loop back
- [ ] Don't skip documentation

---

*See also: [Core Architecture](01_CORE_ARCHITECTURE.md), [Variables & Includes](04_VARIABLES_INCLUDES.md), [Hubs](07_HUBS.md), [View Modes](08_VIEW_MODES.md), [Development environment](10_DEVELOPMENT_ENV.md)*