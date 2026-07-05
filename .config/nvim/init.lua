local home = os.getenv("HOME") or os.getenv("USERPROFILE")
local platform = dofile(home .. "/.config/lua/platform.lua")

vim.loader.enable()
require("config.essentials")
require("config.lazy")

if vim.g.neovide then
  require("config.neovide")
end
