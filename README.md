# AutoSnapWindows for Linux (Devilspie2) - X11 ONLY

Automatically position and resize application windows based on screen resolution and window class matching. Works exclusively with **X11** using the Devilspie2 window matching daemon.

## Overview

This Lua script runs under Devilspie2 to automatically snap application windows to predefined positions and sizes whenever they gain focus. Perfect for multi-monitor setups or when you want consistent window layouts across different screen resolutions.

**Supports:**
- Different presets can be made for each screen resolution.
- Script is currently configured for:
   - 5120x1440 (single monitors setup)
   - 2560x1600 (single monitors setup)

**Applications included:**
- Browsers (Firefox, Chrome, Chromium, Brave)
- Editors & IDEs (VS Code, Codium)
- Terminals (GNOME Terminal, Konsole, Terminator, XFCE)
- Databases (DbGate, DBeaver)
- Media (VLC, Spotify)
- Office (LibreOffice, Thunderbird, Evolution, Teams)
- And more...

## Requirements

- **X11 Display Server** (Wayland not supported)
- **Devilspie2** window daemon
- Linux desktop environment (GNOME, KDE, XFCE, etc.)

## Installation

### 1. Install Devilspie2

```bash
sudo apt update
sudo apt install devilspie2
```

### 2. Place the Script

Copy `AutoSnapWindows.lua` to your Devilspie2 config directory:

```bash
mkdir -p ~/.config/devilspie2
cp AutoSnapWindows.lua ~/.config/devilspie2/
```

### 3. Start Devilspie2

Run in foreground (for testing):
```bash
devilspie2
```

Or run in background:
```bash
devilspie2 &
```

### 4. Autostart (Optional)

Add to your desktop environment's autostart:

**GNOME:**
```bash
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/devilspie2.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Devilspie2
Exec=devilspie2
Hidden=false
EOF
```

**KDE Plasma:**
Add to `~/.config/autostart/devilspie2.desktop` (same as above)

**XFCE:**
Settings → Session and Startup → Application Autostart → Add `devilspie2`

## Configuration

### Rule Format

Each rule is a Lua table with 9 fields:

```lua
{screenRes, appName, class, instance, x, y, width, height, workspaceId}
```

| Field | Type | Description |
|-------|------|-------------|
| `screenRes` | string | Screen resolution as "WIDTHxHEIGHT" (e.g., "5120x1440") |
| `appName` | string | Application name (e.g., "firefox", "code") or `""` to match any |
| `class` | string | Window class name (e.g., "Firefox", "Code") or `""` to match any |
| `instance` | string | Window instance name or `""` to match any |
| `x`, `y` | integer | Window position (top-left corner in pixels) |
| `width`, `height` | integer | Window dimensions in pixels |
| `workspaceId` | integer | Workspace/virtual desktop (0 = current, >0 = specific workspace) |

### How Matching Works

A window matches a rule if **ANY** of these are true (logical OR):
- `appName` matches the application name
- `class` matches the window class
- `instance` matches the window instance
- Empty string `""` matches anything

**Example:** The rule below matches Firefox on any screen resolution:
```lua
{"5120x1440", "firefox", "Firefox", "Navigator", 1280, 0, 2500, 1392, 0}
```

If you use:
```lua
{"5120x1440", "", "Firefox", "", 1280, 0, 2500, 1392, 0}
```
It matches any window with class "Firefox" at that resolution.

## Examples

### Position Firefox on Right Monitor (5120px display)

```lua
{"5120x1440", "firefox", "Firefox", "Navigator", 2500, 0, 2560, 1440, 0}
```

Places Firefox on the right half of a dual-monitor setup (x: 2500-5120px).

### Fullscreen Code on Single 2560px Monitor

```lua
{"2560x1600", "code", "Code", "", 0, 0, 2560, 1600, 0}
```

Maximizes VS Code to fill the entire screen.

### Terminal on Left with Top Offset

```lua
{"5120x1440", "gnome-terminal", "Gnome-terminal", "", 0, 70, 2500, 1300, 0}
```

Positions GNOME Terminal on the left side (width: 2500px, height: 1300px with 70px top offset for taskbars).

### Half-Width File Manager

```lua
{"2560x1600", "nemo", "Nemo", "", 0, 0, 1280, 1600, 0}
```

Positions Nemo file manager on the left half of the screen.

## Finding Window Information

To find the correct `appName`, `class`, and `instance` for your applications:

### Option 1: Using wmctrl
```bash
wmctrl -l
```

Shows all open windows with their class names.

### Option 2: Using xdotool
Focus the window, then run:
```bash
xdotool getactivewindow getwindowname
```

### Option 3: Using xprop
```bash
xprop | grep -E "^WM_CLASS|^_NET_WM_NAME"
```

Click on the window to inspect it. Look for:
- `WM_CLASS(STRING)` = class and instance
- `_NET_WM_NAME(UTF8_STRING)` = window name

## Troubleshooting

### Devilspie2 Not Working

**Check if it's running:**
```bash
pgrep devilspie2
```

**Start in foreground to see errors:**
```bash
devilspie2
```

**Check Devilspie2 logs:**
```bash
tail -f ~/.config/devilspie2/devilspie2.log
```

### Windows Not Being Arranged

1. **Verify screen resolution:** Your actual resolution must match the rule exactly:
   ```bash
   xrandr --current | grep '*'
   ```

2. **Check window type:** Devilspie2 only applies to `WINDOW_TYPE_NORMAL`. Dialogs, tooltips, and menus are skipped automatically.

3. **Verify window class:** Use wmctrl or xprop to find the exact class name:
   ```bash
   wmctrl -l | grep -i firefox
   ```

4. **Check rule syntax:** Make sure all Lua syntax is correct:
   ```bash
   lua -l ~/.config/devilspie2/AutoSnapWindows.lua
   ```

5. **Test with debug output:** Add temporary logging to the script:
   ```lua
   print("Checking window: " .. appName .. " | Class: " .. winClass)
   ```

### Resolution Not Detected Correctly

The script uses `xrandr` to detect resolution. Verify it's correct:
```bash
xrandr --current | grep '*' | head -1 | awk '{print $1}'
```

If the format is different, edit the `getScreenResolution()` function in the script.

### Wayland Users

This script works with **X11 only**. Wayland support requires different APIs. Consider:
- Switching to X11 session
- Using GNOME's built-in window positioning features
- Using KDE's window management tools

## Adding New Applications

1. Find the window class using wmctrl:
   ```bash
   wmctrl -l | grep myapp
   ```

2. Add a rule for each resolution you support:
   ```lua
   {"5120x1440", "myapp", "MyApp", "", 0, 0, 2560, 1440, 0},
   {"2560x1600", "myapp", "MyApp", "", 0, 0, 2560, 1600, 0},
   ```

3. Reload Devilspie2:
   ```bash
   pkill devilspie2
   devilspie2 &
   ```

## Performance Notes

- Devilspie2 runs as a daemon and uses minimal resources
- Rules are evaluated when windows gain focus, not continuously
- Multiple rules for the same resolution are checked in order

## Limitations

- **X11 only**: Wayland is not supported
- **Window manager dependent**: Some window managers may not respect positioning
- **Workspace assignment**: Requires a compositing window manager with virtual desktop support
- **Workspace IDs**: Desktop/workspace numbering varies by DE (GNOME vs KDE vs XFCE)

## Tips & Tricks

### Create a Script to Test Rules Quickly

```bash
#!/bin/bash
pkill devilspie2
sleep 1
devilspie2 &
echo "Restarted Devilspie2"
```

### Monitor Changes in Real-Time

```bash
while inotifywait -e modify ~/.config/devilspie2/AutoSnapWindows.lua; do
    pkill devilspie2
    sleep 1
    devilspie2 &
    echo "Reloaded!"
done
```

### Multi-Resolution Support

Add rules for each resolution you use. The script automatically detects the current resolution and applies matching rules:

```lua
-- High resolution (dual monitors)
{"5120x1440", "firefox", "Firefox", "", 1280, 0, 2500, 1440, 0},

-- Standard resolution (laptop/single monitor)
{"2560x1600", "firefox", "Firefox", "", 0, 0, 2560, 1600, 0},

-- Ultrawide
{"3440x1440", "firefox", "Firefox", "", 860, 0, 2720, 1440, 0},
```

## Related Projects

- **Devilspie2 Documentation**: [Official Docs](https://devilspie2.sourceforge.io/)](https://github.com/dsalt/devilspie2)
- **Devilspie2 Documentation**: [Official Docs](https://devilspie2.sourceforge.io/)

## License

[Specify your license]

## Contributing

Contributions welcome! Feel free to submit:
- New application rules
- Bug reports
- Window class information for common apps
- Performance improvements

---

**Note**: This script works exclusively with X11. For Wayland users, consider using your desktop environment's native window management features.
