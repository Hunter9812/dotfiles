local home = os.getenv("HOME") or os.getenv("USERPROFILE")

require("git"):setup()
require("starship"):setup({ config_file = "~/.config/yazi/starship.toml" })
require("full-border"):setup()
require("eza-preview"):setup({
  level = 3,
  follow_symlinks = true,
  dereference = true
})
require("recycle-bin"):setup({
  -- Optional: Override automatic trash directory discovery
  trash_dir = home .. "/.local/share/Trash",  -- Uncomment to use specific directory
})
