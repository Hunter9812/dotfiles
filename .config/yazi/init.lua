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
