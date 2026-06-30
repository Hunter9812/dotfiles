local c = {}

local wezterm = require('wezterm')
local mux = wezterm.mux
local act = wezterm.action
if wezterm.config_builder then
  c = wezterm.config_builder()
end

local bgcolor = require('theme.bgcolor')
local home = os.getenv("HOME") or os.getenv("USERPROFILE")
local function getOS()
  if jit then
    return jit.os
  end
  -- Unix, Linux variants
  local fh, err = assert(io.popen("uname -o 2>/dev/null", "r"))
  if fh then
    Osname = fh:read()
  end
  return Osname or "Windows"
end
local function split_or_toggle_zoom(direction, size)
  return wezterm.action_callback(function(_, pane)
    local tab = pane:tab()
    local panes = tab:panes_with_info()
    if #panes == 1 then
      pane:split({
        direction = direction,
        size = size or 0.5,
      })
    elseif not panes[1].is_zoomed then
      panes[1].pane:activate()
      tab:set_zoomed(true)
    elseif panes[1].is_zoomed then
      tab:set_zoomed(false)
      if panes[2] then
        panes[2].pane:activate()
      end
    end
  end)
end

if getOS() == "Windows" then
  c.default_prog          = { 'pwsh', '-NoLogo' }
  c.launch_menu           = {
    { label = 'pwsh', args = { 'C:/Program Files/PowerShell/7/pwsh.exe', '-NoLogo' }, },
    { label = 'bash', args = { home .. '/scoop/shims/bash.exe' }, },
    { label = 'cmd',  args = { 'cmd' }, },
  }
  c.wsl_domains           = {
    {
      name = 'WSL:Arch',
      distribution = 'Arch',
      username = 'hunter',
      default_prog = { "zsh" }
    }
  }
  c.window_decorations = "TITLE | RESIZE"
  wezterm.on('gui-startup', function(cmd)
    -- if you want to center a new window on the screen, check this [link](https://github.com/wezterm/wezterm/discussions/5501#discussioncomment-9636644)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
  end)
elseif getOS() == "Linux" or getOS() == "GNU/Linux" then
end

--= Options
c.scrollback_lines = 2000
c.hide_tab_bar_if_only_one_tab = true
c.window_close_confirmation = "NeverPrompt"

--= Appearance
c.font = wezterm.font_with_fallback { 'JetBrainsMono Nerd Font Mono', '霞鹜文楷等宽' }
c.font_size = 14
c.color_scheme = 'Tokyo Night' -- [Color Schemes](https://wezterm.org/colorschemes/index.html)
c.window_padding = { left = '0.5cell', right = '0.5cell', top = '0.2cell', bottom = 0, }
c.background = {{
  source = {
    -- Color = bgcolor.neutral_black_1,
    Color = bgcolor.tokyo_2,
    -- Color = bgcolor.nord_1,
    -- Color = bgcolor.gruvbox_1,
    -- Color = bgcolor.onedark_1,
    -- Color = bgcolor.soft_1,
  },
  width = '100%', height = '100%',
  opacity = 0.9,
}}

--= Keybindings
-- [Default Key Assignments](https://wezterm.org/config/default-keys.html)
-- wezterm --skip-config show-keys --lua > default-keys.lua
c.disable_default_key_bindings = true
c.use_dead_keys = false
c.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 2000 }
c.keys = {
  { key = '|',  mods = 'CTRL|SHIFT', action = act.ShowLauncher },
  { key = '~',  mods = 'CTRL|SHIFT', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },
  { key = 'J',  mods = 'CTRL|SHIFT', action = act.ScrollByLine(5) },
  { key = 'K',  mods = 'CTRL|SHIFT', action = act.ScrollByLine(-5) },
  { key = ']',  mods = 'LEADER',     action = act.ActivateTabRelative(1) },
  { key = '[',  mods = 'LEADER',     action = act.ActivateTabRelative(-1) },
  -- toggle a split, [link](https://github.com/wezterm/wezterm/discussions/3779#discussioncomment-8923369)
  { key = "t",  mods = "ALT",        action = split_or_toggle_zoom("Right"), },
  { key = "\\", mods = "CTRL",       action = split_or_toggle_zoom("Bottom"), },
  -- Vim-like logic
  { key = "q",  mods = "LEADER", action = act.CloseCurrentPane { confirm = false } },
  { key = "p",  mods = "LEADER", action = act.PaneSelect { alphabet = '', mode = 'Activate', show_pane_ids = false } },
  { key = "x",  mods = "LEADER", action = act.PaneSelect { alphabet = '', mode = 'SwapWithActive', show_pane_ids = false } },
  { key = "s",  mods = "LEADER", action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = "v",  mods = "LEADER", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'k',  mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'j',  mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'h',  mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'l',  mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  -- Base
  { key = 'P', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
  { key = '0', mods = 'CTRL',       action = act.ResetFontSize },
  { key = '-', mods = 'CTRL',       action = act.DecreaseFontSize },
  { key = '+', mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
  { key = '=', mods = 'CTRL',       action = act.IncreaseFontSize },
  { key = 'N', mods = 'CTRL|SHIFT', action = act.SpawnWindow },
  { key = 'T', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'W', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false } },
  { key = 'C', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'V', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  { key = 'm', mods = 'CTRL',       action = act.TogglePaneZoomState },
  { key = 'D', mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },
  -- [Search Mode](https://wezterm.org/scrollback.html#searching-the-scrollback)
  { key = 'F', mods = 'CTRL|SHIFT', action = act.Search 'CurrentSelectionOrEmptyString' },
  -- [Copy Mode](https://wezterm.org/copymode.html#key-assignments)
  { key = 'X', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode },
  -- [Quick Select Mode](https://wezterm.org/quickselect.html)
  { key = 'phys:Space', mods = 'CTRL|SHIFT',     action = act.QuickSelect },
  { key = 'Tab',        mods = 'CTRL',           action = act.ActivateTabRelative(1) },
  { key = 'Tab',        mods = 'CTRL|SHIFT',     action = act.ActivateTabRelative(-1) },
  { key = 'F11',        mods = '',               action = act.ToggleFullScreen },
  { key = 'Enter',      mods = 'ALT',            action = act.ToggleFullScreen },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT',     action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT',     action = act.ActivatePaneDirection 'Down' },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT',     action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT',     action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CTRL|ALT|SHIFT', action = act.AdjustPaneSize { 'Up', 1 } },
  { key = 'DownArrow',  mods = 'CTRL|ALT|SHIFT', action = act.AdjustPaneSize { 'Down', 1 } },
  { key = 'LeftArrow',  mods = 'CTRL|ALT|SHIFT', action = act.AdjustPaneSize { 'Left', 1 } },
  { key = 'RightArrow', mods = 'CTRL|ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 1 } },
  { key = 'PageUp',     mods = 'SHIFT',          action = act.ScrollByPage(-1) },
  { key = 'PageUp',     mods = 'CTRL|SHIFT',     action = act.MoveTabRelative(-1) },
  { key = 'PageDown',   mods = 'SHIFT',          action = act.ScrollByPage(1) },
  { key = 'PageDown',   mods = 'CTRL|SHIFT',     action = act.MoveTabRelative(1) },
  { key = '9', mods = 'ALT', action = act.ActivateTab(-1) },
}
for i = 1, 8 do
  table.insert(c.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

c.mouse_bindings = {
  -- bind mouse right-click with Copy & Paste, like in pwsh. [link](https://github.com/wezterm/wezterm/discussions/3541#discussioncomment-5633570)
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  },

  -- scrolling 3 lines per wheel tick (both up and down). [link](https://github.com/wezterm/wezterm/issues/3142#issuecomment-1518907658)
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'NONE',
    action = act.ScrollByLine(-3),
    alt_screen = false,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = act.ScrollByLine(3),
    alt_screen = false,
  },

  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  -- and make CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
  -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.Nop,
  },

  -- Scrolling up/down while holding CTRL increases/decreases the font size
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
}

return c
