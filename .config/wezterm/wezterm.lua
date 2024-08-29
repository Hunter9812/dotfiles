local c = {}

local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local gpus = wezterm.gui.enumerate_gpus()
local materia = wezterm.color.get_builtin_schemes()['Material Darker (base16)']

if wezterm.config_builder then
    c = wezterm.config_builder()
end

--. Appearance
c.font_size = 12.0
c.initial_cols = 128
c.initial_rows = 32
c.font = wezterm.font 'JetBrainsMono Nerd Font'
c.font = wezterm.font_with_fallback {
    'JetBrainsMono Nerd Font',
    '霞鹜文楷'
}
c.window_background_image = '/home/hunter/Pictures/Misc/Config/wallpaper.landscape.png'
c.window_background_opacity = 0.8
c.window_background_image_hsb = {
    hue = 1.0,
    saturation = 0.9,
    brightness = 0.1,
}
c.colors = materia
c.window_padding = { left = 0, right = 15, top = 0, bottom = 0 }
c.enable_scroll_bar = true
materia.scrollbar_thumb = '#cccccc' -- 更明显的滚动条


--. Essential
c.enable_wayland = false
c.window_close_confirmation = 'NeverPrompt'

--. KeyBoard
c.use_dead_keys = false
c.webgpu_preferred_adapter = gpus[1]
c.front_end = 'WebGpu'
c.animation_fps = 10
c.disable_default_key_bindings = true
c.keys = {
    -- 遍历 tab
    { key = 'Tab', mods = 'CTRL',       action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    -- 切换全屏
    { key = 'F11', mods = 'NONE',       action = act.ToggleFullScreen },
    -- 增大字体
    { key = '+',   mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    -- 减小字体
    { key = '_',   mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    -- 重置字体
    { key = '0',   mods = 'CTRL',       action = act.ResetFontAndWindowSize },
    -- 复制选中区域
    { key = 'C',   mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    -- 新窗口
    { key = 'N',   mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    -- 新 tab
    { key = 'P',   mods = 'SHIFT|CTRL', action = act.ShowLauncher },
    -- 显示启动菜单
    { key = '~',   mods = 'SHIFT|CTRL', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },
    -- 粘贴剪切板的内容
    { key = 'V',   mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    -- 关闭 tab 且不进行确认
    { key = 'W',   mods = 'SHIFT|CTRL', action = act.CloseCurrentTab { confirm = false } },
    -- 上下滚动
    { key = 'J',   mods = 'SHIFT|CTRL', action = act.ScrollByLine(-5) },
    { key = 'K',   mods = 'SHIFT|CTRL', action = act.ScrollByLine(5) },
}
-- bind mouse right-click with Copy & Paste, like in pwsh
c.mouse_bindings = {
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
}

return c
