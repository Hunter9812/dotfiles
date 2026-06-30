vim.loader.enable()
require("config.essentials")
require("config.lazy")

if vim.g.neovide then
  require("config.neovide")
end
