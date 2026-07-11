-- This is an Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output   = "",
  mode     = "highres",
  position = "auto",
  scale    = "auto",
})

-- Recommended rule for quickly plugging in random monitors:
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = 'wezterm'
local fileManager = 'LANG=zh_CN.UTF-8 nautilus' -- dolphin
-- [Launching a different program as a one off via the CLI](https://wezterm.org/config/launch.html#launching-a-different-program-as-a-one-off-via-the-cli)
local taskManager = 'wezterm start -- btop'
local browser     = 'firefox'
local dict        = 'QT_IM_MODULE=fcitx eusoft-eudic'

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
hl.on("hyprland.start", function()
  -- Service
  hl.exec_cmd('systemctl --user start hyprpolkitagent')
  hl.exec_cmd('systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP')
  hl.exec_cmd('dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP')
  hl.exec_cmd('~/.config/hypr/script/xdph-nuclear-reset.sh')
  hl.exec_cmd('snappy-switcher --daemon')
  -- now is holden by Noctalia
  -- hl.exec_cmd('wl-paste --type text --watch cliphist store')
  -- hl.exec_cmd('wl-paste --type image --watch cliphist store')

  -- Desktop
  hl.exec_cmd('fcitx5')
  hl.exec_cmd('qs -c noctalia-shell')

  -- Usual
  hl.exec_cmd(browser)
  hl.exec_cmd('mihomo-party')
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- Cursor size.
hl.env("GDK_SCALE", "1.5")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Force all apps to use Wayland.
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Allow better support for screen sharing (Google Meet, Discord, etc).
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
  ecosystem = {
    no_update_news  = true,
    no_donation_nag = true,
  },
})

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in          = 5,
    gaps_out         = 10,

    border_size      = 0,

    col              = {
      -- active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      -- inactive_border = "rgba(595959aa)",
      active_border   = "rgba(707070ff)",
      inactive_border = "rgba(d0d0d0ff)",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = true,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing    = false,

    locale           = "en_US",
  },

  decoration = {
    rounding         = 12,
    rounding_power   = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 1.0,
    inactive_opacity = 0.9,

    shadow           = {
      enabled      = true,
      range = 4,
      render_power = 3,
      color = "rgba(00000070)", -- 0xee1a1a1a
    },

    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 2,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

hl.config({
  general = {
    layout = "scrolling",
  },
  -- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
  scrolling = {
    column_width = 1.0,
  },
  -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
  dwindle = {
    preserve_split = true,     -- You probably want this
  },
  -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
  master = {
    mfact = 0.70,
  },
})

----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    force_default_wallpaper = 0,        -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = true,     -- If true disables the random hyprland logo / anime girl background. :(
  },
})


---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout          = "us",
    kb_variant         = "",
    kb_model           = "",
    kb_options         = "",
    kb_rules           = "",

    numlock_by_default = true,

    sensitivity        = 0, -- -1.0 - 1.0, 0 means no modification.

    follow_mouse       = 1,
    focus_on_close     = 2,

    touchpad           = {
      natural_scroll = true,
      scroll_factor  = 0.6,
      drag_lock      = 2,
    },
  },
  cursor = {
    inactive_timeout = 5,
    zoom_rigid = true,
    zoom_detached_camera = false,
  },
})

--= Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", mods = "ALT", action = "close" })
hl.gesture({ fingers = 3, direction = "up", mods = "SUPER", scale = 1.5, action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "down", mods = "SUPER", scale = 1.5, action = "fullscreen" })
hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
  name        = "epic-mouse-v1",
  sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local ipc = "qs -c noctalia-shell ipc call"
local launcher = ipc .. " launcher"

--= App binds
hl.bind("SUPER + backslash", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd(browser))
hl.bind("CTRL + SHIFT + Q", hl.dsp.exec_cmd(dict))
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd('hyprpicker --autocopy --notify --render-inactive --lowercase-hex --scale=2 --radius=150'))

--= Core binds
hl.bind("ALT + space", hl.dsp.exec_cmd(launcher .. " toggle"))
hl.bind("SUPER + I", hl.dsp.exec_cmd(ipc .. " settings toggle"))
hl.bind("SUPER + S", hl.dsp.exec_cmd(ipc .. " controlCenter toggle"))
hl.bind("SUPER + U", hl.dsp.exec_cmd(ipc .. " sessionMenu toggle"))
-- SUPER + L is used for Vim-style window movement, so this is remapped to a macOS-style shortcut
hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd(ipc .. " lockScreen lock"))
hl.bind("SUPER + C", hl.dsp.exec_cmd(ipc .. " calendar toggle"))
hl.bind("SUPER + R", hl.dsp.exec_cmd(launcher .. " command"))
hl.bind("SUPER + slash", hl.dsp.exec_cmd(launcher .. " windows"))
hl.bind("SUPER + V", hl.dsp.exec_cmd(launcher .. " clipboard"))
hl.bind("CTRL + grave", hl.dsp.exec_cmd(launcher .. " clipboard"))
hl.bind("SUPER + M", hl.dsp.exec_cmd(ipc .. " systemMonitor toggle"))
hl.bind("CTRL + SHIFT + escape", hl.dsp.exec_cmd(taskManager))

--= Window binds
hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind("SUPER + F4", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
-- hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + ALT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
-- Keeps the window non-fullscreen, but the client goes into fullscreen mode within the window.
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }))
-- Fullscreens the application and keeps the client in non-fullscreen mode.
hl.bind("ALT + Return", hl.dsp.window.fullscreen_state({ internal = 2, client = 0 }))

-- Move focus
hl.bind("ALT + Tab", hl.dsp.exec_cmd("snappy-switcher next --mod alt"),
  { description = "Snappy Switcher" })
hl.bind("SUPER + TAB", hl.dsp.exec_cmd("snappy-switcher next --workspace --mod super"),
  { description = "Snappy Switcher (Workspace)" })
-- hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }))
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + SHIFT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.swap({ direction = "d" }))
hl.bind("SUPER + SHIFT + comma", hl.dsp.layout("consume_or_expel prev"))  -- only for Scrolling
hl.bind("SUPER + SHIFT + period", hl.dsp.layout("consume_or_expel next")) -- only for Scrolling
-- Vim-like
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch to a submap called `resize`.
hl.bind("ALT + R", hl.dsp.submap("resize"))
-- Start a submap called "resize".
hl.define_submap("resize", function()
  -- Set repeating binds for resizing the active window.
  hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind("down", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  -- Use `reset` to go back to the global submap
  hl.bind("escape", hl.dsp.submap("reset"))
end)

--= Workspace binds
-- hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

for i = 1, 9 do
  hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
  hl.bind("SUPER + SHIFT + ALT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- "desktop" workspace
hl.bind("SUPER + D", hl.dsp.exec_cmd("~/.config/hypr/script/toggle_desktop.sh"))
hl.bind("SUPER + SHIFT + D", hl.dsp.window.move({ workspace = 10 }))
hl.bind("SUPER + SHIFT + ALT + D", hl.dsp.window.move({ workspace = 10, follow = false }))

-- Special workspace (scratchpad)
hl.bind("SUPER + grave", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind("SUPER + SHIFT + grave", hl.dsp.window.move({ workspace = "special:scratchpad" }))
hl.bind("SUPER + ALT + grave", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

--= Monitor binds
hl.bind("SUPER + SHIFT + ALT + LEFT", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind("SUPER + SHIFT + ALT + RIGHT", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind("SUPER + SHIFT + ALT + UP", hl.dsp.workspace.move({ monitor = "u" }))
hl.bind("SUPER + SHIFT + ALT + DOWN", hl.dsp.workspace.move({ monitor = "d" }))
hl.bind("CTRL + ALT + TAB", hl.dsp.focus({ monitor = "+1" }))
hl.bind("CTRL + ALT + SHIFT + TAB", hl.dsp.focus({ monitor = "-1" }))

--= Window Group binds, it's like Tab in Browser
hl.bind("SUPER + G", hl.dsp.group.toggle())
hl.bind("SUPER + ALT + G", hl.dsp.window.move({ out_of_group = true }))

hl.bind("SUPER + ALT + TAB", hl.dsp.group.next())
hl.bind("SUPER + ALT + SHIFT + TAB", hl.dsp.group.prev())

hl.bind("SUPER + ALT + LEFT", hl.dsp.window.move({ into_group = "l" }))
hl.bind("SUPER + ALT + RIGHT", hl.dsp.window.move({ into_group = "r" }))
hl.bind("SUPER + ALT + UP", hl.dsp.window.move({ into_group = "u" }))
hl.bind("SUPER + ALT + DOWN", hl.dsp.window.move({ into_group = "d" }))
hl.bind("SUPER + ALT + H", hl.dsp.window.move({ into_group = "l" }))
hl.bind("SUPER + ALT + L", hl.dsp.window.move({ into_group = "r" }))
hl.bind("SUPER + ALT + K", hl.dsp.window.move({ into_group = "u" }))
hl.bind("SUPER + ALT + J", hl.dsp.window.move({ into_group = "d" }))

hl.bind("SUPER + CTRL + LEFT", hl.dsp.group.prev())
hl.bind("SUPER + CTRL + RIGHT", hl.dsp.group.next())
hl.bind("SUPER + CTRL + H", hl.dsp.group.prev())
hl.bind("SUPER + CTRL + L", hl.dsp.group.next())
hl.bind("SUPER + CTRL + K", hl.dsp.group.prev())
hl.bind("SUPER + CTRL + J", hl.dsp.group.next())

hl.bind("SUPER + ALT + mouse_down", hl.dsp.group.next())
hl.bind("SUPER + ALT + mouse_up", hl.dsp.group.prev())

for i = 1, 5 do
  hl.bind("SUPER + ALT + " .. i, hl.dsp.group.active({ index = i }))
end

-- Laptop multimedia keys for volume and LCD brightness
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
-- hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume increase"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume decrease"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness increase"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness decrease"), { locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--= Uncommon tips & tricks
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Uncommon-tips-and-tricks/

-- Minimize windows using special workspaces
hl.bind("SUPER + F1", function()
  local game_mode = (hl.get_config("animations.enabled") == false)

  if game_mode then
    hl.exec_cmd("hyprctl reload")
    return
  end

  hl.config({
    general = {
      gaps_in = 0,
      gaps_out = 0,                    -- Disable gaps
      border_size = 0,
    },

    animations = {
      enabled = false,       -- Disable animations
    },

    -- Disable blur, shadow and window rounding
    decoration = {
      shadow = { enabled = false },
      blur = { enabled = false },
      rounding = 0,
    }
  })
end)

-- Glass magnifier zoom
local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

---@param offset number
---@return nil
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end
hl.bind("SUPER + equal", function() zoom(0.5) end, { repeating = true })
hl.bind("SUPER + minus", function() zoom(-0.5) end, { repeating = true })
hl.bind("SUPER + 0", zoom)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

--= Window Rules
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
--== App
-- Disable blur for firefox
hl.window_rule({ match = { class = "firefox" }, no_blur = true })
hl.window_rule({
  match = { title = "^(关于 Mozilla Firefox|About Mozilla Firefox)$", class = "firefox" }, float = true,
  rounding = 0, no_shadow = true, opaque = true,
})
hl.window_rule({
  match = { title = "^(画中画|Picture-in-Picture)$" },
  float = true, no_initial_focus = true, pin = true, content = "video",
  size = { "(monitor_w*0.22)", "(monitor_h*0.22)" },
  move = { "(monitor_w*0.75)", "(monitor_h*0.01)" }, -- top right
  -- move = {"(monitor_h*0.01)", "(monitor_h*0.01)"}, -- top left
  rounding = 0, decorate = false, no_shadow = true, opaque = true,
})
hl.window_rule({
  match = { class = "eudic" },
  float = true,
  size = { "monitor_w * 0.6", "monitor_h * 0.55" },
  move = { "monitor_w * 0.37", "monitor_h * 0.45" },
})
hl.window_rule({
  match = { class = "jetbrains-toolbox" },
  move = { "(monitor_w*0.75)", "(monitor_h*0.01)" }, -- top right
})
--=== Legacy
hl.window_rule({
  match = { class = "flameshot" },
  float = true, pin = true, move = { 0, 0 },
  opaque = true, decorate = false, no_blur = true, no_shadow = true,
})
hl.window_rule({ match = { title = "flameshot-pin" }, content = "photo", persistent_size = true, })

--== Plugins
-- Blur for the Noctalia bar and panels background
hl.layer_rule({
  name = "noctalia",
  match = { namespace = "noctalia-background-.*$" },
  ignore_alpha = 0.5, blur = true, blur_popups = true,
})

-- Liquid Glass blur rules
hl.layer_rule({
  match = { namespace = "snappy-switcher" },
  blur         = true,
  ignore_alpha = 0.1,
})

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})
hl.window_rule({
    name = "xwayland-video-bridge-fixes",
    match = { class = "xwaylandvideobridge" },
    no_initial_focus = true,
    no_focus = true,
    no_anim  = true,
    no_blur  = true,
    max_size = { 1, 1 },
    opacity  = 0.0,
})

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move  = "20 monitor_h-120",
  float = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

--= Workspace Rules
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.workspace_rule({ workspace = "1", default_name = "browse" })
hl.workspace_rule({ workspace = "2", default_name = "code", layout_opts = { direction = "down" } })
hl.workspace_rule({ workspace = "3", default_name = "play" })
hl.workspace_rule({ workspace = "9", default_name = "ai", layout_opts = { direction = "down" } })
hl.workspace_rule({ workspace = "10", default_name = "desktop" })
hl.workspace_rule({ workspace = "special:scratchpad", layout_opts = { direction = "down" } })

-- Smart gaps (ignoring special workspaces)
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, rounding = 0 })
