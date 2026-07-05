local home = os.getenv("HOME") or os.getenv("USERPROFILE")
-- https://github.com/sxyazi/yazi/issues/3682
local platform = dofile(home .. "/.config/lua/platform.lua")

require("git"):setup()
require("starship"):setup({ config_file = home .. "/.config/yazi/starship.toml" })
require("full-border"):setup()
require("eza-preview"):setup({
  level = 3,
  follow_symlinks = true,
  dereference = true
})

if platform.is_linux() then
  require("recycle-bin"):setup({
    -- Optional: Override automatic trash directory discovery
    trash_dir = home .. "/.local/share/Trash",  -- Uncomment to use specific directory
  })
end
