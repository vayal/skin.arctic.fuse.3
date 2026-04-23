# Development Environment Setup

## Overview

This guide covers setting up a development environment for Kodi skin development, specifically for the Arctic Fuse 3 Velocity fork.

---

## 1. Prerequisites

### Required Software

| Software | Purpose | Installation |
|---|---|---|
| **Kodi** | Target platform | Download from kodi.tv |
| **Git** | Version control | `sudo apt install git` |
| **VS Code** | IDE | Download from code.visualstudio.com |
| **Node.js** | Build tools | `curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt install nodejs` |
| **npm** | Package manager | Installed with Node.js |

### Kodi Versions

| Kodi Version | Status | Notes |
|---|---|---|
| 21 (Matrix) | Supported | Primary target |
| 22 (Nexus) | Supported | Secondary target |
| 23 (Omega) | Not yet supported | Future target |

---

## 2. Development Environment Setup

### Clone the Repository

```bash
git clone https://github.com/vayal/skin.arctic.fuse.3.git
cd skin.arctic.fuse.3
```

### Install Dependencies

```bash
# Install build dependencies
sudo apt install -y build-essential libncurses5-dev \
  libssl-dev libfontconfig1-dev libfreetype6-dev \
  libx11-dev libxi-dev libxinerama-dev libxrandr-dev

# Install Kodi development tools
sudo apt install -y kodi-dev
```

### Set Up VS Code

1. **Install VS Code extensions:**
   - XML Tools
   - Prettier
   - GitLens
   - Kodi Skin Tools (if available)

2. **Create `.vscode/settings.json`:**

```json
{
  "xml.formatting": "prettier",
  "prettier.printWidth": 120,
  "prettier.tabWidth": 2,
  "prettier.useTabs": false,
  "files.exclude": {
    "**/.git": true,
    "**/node_modules": true,
    "**/node": true
  },
  "editor.quickSuggestions": {
    "other": true,
    "comments": false,
    "strings": true
  }
}
```

---

## 3. Kodi Skin Testing Setup

### Kodi Installation

1. **Download Kodi:**
   - Visit https://kodi.tv/download
   - Choose your platform (Linux, Windows, macOS, Android TV, etc.)

2. **Install Kodi:**
   - Follow platform-specific installation instructions

3. **Enable Kodi Addons:**
   - Go to Settings → Add-ons → Enable Kodi Add-ons

### Kodi Configuration

1. **Enable Debug Mode:**
   - Go to Settings → System → Debugging → Enable debug mode

2. **Set Kodi log location:**
   - Linux: `~/.kodi/log/kodi.log`
   - Windows: `%APPDATA%\Kodi\log\kodi.log`
   - macOS: `~/Library/Application Support/Kodi/log/kodi.log`

### Kodi Skin Installation

1. **Install the skin:**
   - Go to Settings → Interface → Skin → Settings
   - Click "Install new skin"
   - Select the skin archive or folder

2. **Set as default skin:**
   - Go to Settings → Interface → Skin
   - Select "Arctic Fuse 3 Velocity"
   - Click "Set as default"

---

## 4. Development Workflow

### Making Changes

1. **Edit XML files:**
   - Use VS Code or your preferred editor
   - Follow the coding conventions in [Best Practices](09_BEST_PRACTICES.md)

2. **Test in Kodi:**
   - Launch Kodi
   - Navigate to the affected area
   - Verify the changes

3. **Check logs:**
   - Open the Kodi log
   - Look for errors or warnings
   - Use search to find relevant messages

### Common Development Tasks

#### Adding a New Control

```xml
<control type="label" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>1920</width>
  <height>60</height>
  <label>Test Label</label>
  <font>font14</font>
  <size>24</size>
  <color>FF000000</color>
</control>
```

#### Adding a New Button

```xml
<control type="button" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>300</width>
  <height>60</height>
  <label>Test Button</label>
  <onclick>ActivateWindow(home)</onclick>
  <focusedbackground>skin://textures/buttons/focused.png</focusedbackground>
  <unfocusedbackground>skin://textures/buttons/unfocused.png</unfocusedbackground>
  <select>1</select>
</control>
```

#### Adding a New List

```xml
<control type="list" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>1920</width>
  <height>600</height>
  <label>Test List</label>
  <itemheight>60</itemheight>
  <itemwidth>1920</itemwidth>
  <focus>1</focus>
  <scrolltime>300</scrolltime>
</control>
```

---

## 5. Debugging Tools

### Kodi Debug Mode

1. **Enable debug mode:**
   - Go to Settings → System → Debugging → Enable debug mode

2. **View debug output:**
   - Press `F11` (Windows/Linux) or `Option+F11` (macOS)
   - View the debug console

### Kodi Log Files

| Log File | Purpose |
|---|---|
| `kodi.log` | Main log file |
| `kodi.log.old` | Previous log files |
| `kodi.db` | Kodi database |

### Velocity Debug

1. **Enable Velocity debug:**
   - Go to Add-ons → Video Add-ons → Velocity
   - Click "Settings"
   - Enable "Debug mode"

2. **View Velocity debug output:**
   - Check the Kodi log for Velocity messages
   - Look for contract data and widget rendering

### Skin Variables Debug

1. **Enable skin variables debug:**
   - Go to Add-ons → System Add-ons → script.skinvariables
   - Click "Settings"
   - Enable "Debug mode"

2. **View skin variables debug output:**
   - Check the Kodi log for skin variables messages
   - Look for variable resolution and evaluation

---

## 6. Common Development Issues

### Issue: Content not displaying

**Cause:** View mode not enforced or item dimensions not set

**Solution:**
```xml
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>
```

### Issue: Horizontal scrolling issues

**Cause:** Row view not enforced

**Solution:**
```xml
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>
```

### Issue: Grid layout issues

**Cause:** Wall view not enforced

**Solution:**
```xml
<view mode="wall">
  <controls>
    <control type="list" id="1001">
      <itemheight>180</itemheight>
      <itemwidth>480</itemwidth>
    </control>
  </controls>
</view>
```

---

## 7. Resources

### Documentation

- [Kodi Skin Development Guide](https://kodi.wiki/index.php/Skin_development)
- [script.skinvariables Documentation](https://github.com/script.skinvariables/script.skinvariables)
- [Velocity Addon Documentation](https://github.com/velocity-addon/plugin.video.velocity2)

### Tools

- [Kodi Skin Editor](https://github.com/kodi-addons/kodi-skin-editor)
- [Kodi Log Viewer](https://github.com/kodi-addons/kodi-log-viewer)
- [Kodi Remote Control](https://github.com/kodi-addons/kodi-remote-control)

---

*See also: [Best Practices](09_BEST_PRACTICES.md), [Testing & Debugging](11_TESTING_DEBUGGING.md), [Deployment](12_DEPLOYMENT.md)*