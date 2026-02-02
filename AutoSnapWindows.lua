

-- ============================================================================
-- AutoSnapWindows for Linux (Devilspie2) - ONLY for X11
-- ============================================================================
-- PURPOSE & TECHNOLOGY:
-- Automatically positions and resizes application windows based on screen
-- resolution and window class matching. Works with Devilspie2, a window
-- matching daemon for X11/Linux that triggers this script on window focus.
--
-- FILE LOCATION:
-- Place this file in: ~/.config/devilspie2/AutoSnapWindows.lua
-- Devilspie2 automatically loads all .lua files from this directory.
--
-- INSTALLATION:
-- Install Devilspie2:
--   sudo apt install devilspie2
-- Start it:
--   devilspie2 &
-- Or add to autostart for your desktop environment (GNOME/KDE/XFCE).
-- ============================================================================

-- A lua table to hold window positioning rules.
-- screenResolution example: "1920x1080"
-- appName example: "firefox" or ""
-- class example: "Firefox" or ""
-- instance example: "Navigator" or ""
-- x, y, width, height: integers for window position and size
-- workspaceId: integer for workspace number (0 for current workspace) or 0 (no change)
-- Columns: 
--   {screenRes, appName,    class,     instance, x, y, width, height, workspaceId}

-- Format: {screenRes, appName, class, instance, x, y, width, height, workspaceId}
-- 5120px wide monitor (5120x1440) rules
windowRules = {
    
    -- 5120px wide monitor (5120x1440) rules

    -- Browsers
    {"5120x1440", "firefox",    "Firefox",           "Navigator", 1280, 0, 2500, 1392, 0},
    {"5120x1440", "google-chrome", "Google-chrome",  "", 1280, 0, 2500, 1392, 0},
    {"5120x1440", "chromium",   "Chromium",          "", 1280, 0, 2500, 1392, 0},
    {"5120x1440", "brave",      "Brave-browser",     "", 1280, 0, 2500, 1392, 0},
    
    -- Editors & IDEs
    {"5120x1440", "code",       "Code",              "", 930, 0, 3200, 1392, 0},
    {"5120x1440", "codium",     "Codium",            "", 930, 0, 3200, 1392, 0},
    
    -- Databases
    {"5120x1440", "dbgate",     "DbGate",            "", 0, 0, 3700, 1392, 0},
    
    -- File Manager
    {"5120x1440", "nemo",       "Nemo",              "", 0, 0, 2500, 1392, 0},
    
    -- Text Editors
    {"5120x1440", "gedit",      "Gedit",             "", 0, 0, 2500, 1392, 0},
    {"5120x1440", "mousepad",   "Mousepad",          "", 0, 0, 2500, 1392, 0},
    
    -- Note Taking
    {"5120x1440", "obsidian",   "obsidian",          "", 1280, 0, 2500, 1392, 0},
    {"5120x1440", "joplin",     "Joplin",            "", 0, 0, 2500, 1392, 0},
    
    -- API Testing
    {"5120x1440", "postman",    "Postman",           "", 0, 0, 2560, 1392, 0},
    
    -- Media
    {"5120x1440", "spotify",    "Spotify",           "", 1280, 0, 2500, 1392, 0},
    {"5120x1440", "vlc",        "vlc",               "", 0, 0, 5120, 1392, 0},
    
    -- Terminal
    {"5120x1440", "gnome-terminal", "Gnome-terminal", "", 0, 70, 2500, 1300, 0},
    {"5120x1440", "konsole",    "Konsole",           "", 0, 70, 2500, 1300, 0},
    {"5120x1440", "terminator", "Terminator",        "", 0, 70, 2500, 1300, 0},
    {"5120x1440", "xfce4-terminal", "Xfce4-terminal", "", 0, 70, 2500, 1300, 0},
    
    -- Office & Productivity
    {"5120x1440", "libreoffice", "libreoffice",      "", 0, 0, 2500, 1392, 0},
    {"5120x1440", "soffice",    "libreoffice",       "", 0, 0, 2500, 1392, 0},
    {"5120x1440", "thunderbird", "Thunderbird",      "", 2500, 0, 2500, 1392, 0},
    {"5120x1440", "evolution",  "Evolution",         "", 2500, 0, 2500, 1392, 0},
    {"5120x1440", "teams",      "Microsoft-Teams",   "", 0, 0, 2500, 1392, 0},
    
    -- Database Clients
    {"5120x1440", "dbeaver",    "dbeaver",           "", 0, 0, 2500, 1392, 0},

    -- 2560px monitor (2560x1600) rules
    
    -- Browsers
    {"2560x1600", "firefox",    "Firefox",           "Navigator", 0, 0, 2560, 1600, 0},
    {"2560x1600", "google-chrome", "Google-chrome",  "", 0, 0, 2560, 1600, 0},
    {"2560x1600", "chromium",   "Chromium",          "", 0, 0, 2560, 1600, 0},
    {"2560x1600", "brave",      "Brave-browser",     "", 0, 0, 2560, 1600, 0},
    
    -- Editors & IDEs
    {"2560x1600", "code",       "Code",              "", 0, 0, 2560, 1600, 0},
    {"2560x1600", "codium",     "Codium",            "", 0, 0, 2560, 1600, 0},
    
    -- Databases
    {"2560x1600", "dbgate",     "DbGate",            "", 0, 0, 2560, 1600, 0},
    
    -- File Manager
    {"2560x1600", "nemo",       "Nemo",              "", 0, 0, 1280, 1600, 0},
    
    -- Text Editors
    {"2560x1600", "gedit",      "Gedit",             "", 0, 0, 1280, 1600, 0},
    {"2560x1600", "mousepad",   "Mousepad",          "", 0, 0, 1280, 1600, 0},
    -- Note Taking
    {"2560x1600", "obsidian",   "obsidian",          "", 0, 0, 2560, 1600, 0},
    {"2560x1600", "joplin",     "Joplin",            "", 0, 0, 2560, 1600, 0},
    
    -- API Testing
    {"2560x1600", "postman",    "Postman",           "", 0, 0, 2560, 1600, 0},
    
    -- Media
    {"2560x1600", "spotify",    "Spotify",           "", 0, 0, 2560, 1600, 0},
    {"2560x1600", "vlc",        "vlc",               "", 0, 0, 2560, 1600, 0},
    
    -- Terminal
    {"2560x1600", "gnome-terminal", "Gnome-terminal", "", 0, 62, 2560, 1530, 0},
    {"2560x1600", "konsole",    "Konsole",           "", 0, 62, 2560, 1530, 0},
    {"2560x1600", "terminator", "Terminator",        "", 0, 62, 2560, 1530, 0},
    {"2560x1600", "xfce4-terminal", "Xfce4-terminal", "", 0, 62, 2560, 1530, 0},
    
    -- Office & Productivity
    {"2560x1600", "libreoffice", "libreoffice",      "", 0, 0, 2560, 1600, 0},
    {"2560x1600", "soffice",    "libreoffice",       "", 0, 0, 2560, 1600, 0},
    {"2560x1600", "thunderbird", "Thunderbird",      "", 2560, 0, 2560, 1600, 0},
    {"2560x1600", "evolution",  "Evolution",         "", 2560, 0, 2560, 1600, 0},
    {"2560x1600", "teams",      "Microsoft-Teams",   "", 0, 0, 2560, 1600, 0},
    
    -- Database Clients
    {"2560x1600", "dbeaver",    "dbeaver",           "", 0, 0, 2560, 1600, 0},
}

winClass=get_window_class()
winType=get_window_type()
appName=get_application_name()
classInstanceName=get_class_instance_name()
windowHasName=get_window_has_name()

-- get_window_type() - Documentation:
-- - Returns the type of the window. The result type is a string, and can be one of the following:
-- - WINDOW_TYPE_NORMAL
-- - WINDOW_TYPE_DESKTOP
-- - WINDOW_TYPE_DOCK
-- - WINDOW_TYPE_DIALOG
-- - WINDOW_TYPE_TOOLBAR
-- - WINDOW_TYPE_MENU
-- - WINDOW_TYPE_UTILITY
-- - WINDOW_TYPE_SPLASHSCREEN
-- - WINDOW_TYPE_UNRECOGNIZED (if libwnck didn't recognise the type)
-- - WINDOW_ERROR (if there's no window to work on)

-- Code Flow:
-- 1. Get current screen resolution
-- 2. Loop through windowRules table
-- 3. If current screen resolution matches rule's screenResolution
-- 4. Check if appName, class, and instance match (if specified in rule)
-- 5. If all match, set window position, size, and workspace as per rule

-- Function to get screen resolution using xrandr
function getScreenResolution()
    local handle = io.popen("xrandr --current | grep '*' | head -1 | awk '{print $1}'")
    local result = handle:read("*a")
    handle:close()
    return result:gsub("\n", "")
end

-- Get current screen resolution
local screenResolution = getScreenResolution()

-- Loop through windowRules and apply matching rule
for _, rule in ipairs(windowRules) do
    local ruleResolution = rule[1]
    local ruleAppName = rule[2]
    local ruleClass = rule[3]
    local ruleInstance = rule[4]
    local posX = rule[5]
    local posY = rule[6]
    local sizeW = rule[7]
    local sizeH = rule[8]
    local workspaceId = rule[9]
    
    -- Check if screen resolution matches
    if screenResolution == ruleResolution then
        -- Skip desktop, dialogs, and other non-normal windows
        if winType == "WINDOW_TYPE_NORMAL" then
            -- Check if appName, class, and instance all match (empty string means any)
            if (appName == ruleAppName or winClass == ruleClass or classInstanceName == ruleInstance) then
                -- All criteria matched, apply the rule
                set_window_position(posX, posY)
                set_window_size(sizeW, sizeH)
                if workspaceId and workspaceId > 0 then
                    set_window_workspace(workspaceId)
                end
                break
            end
        end
    end
end
