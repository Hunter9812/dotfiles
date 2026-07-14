local function set_tab2()
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "bash", "zsh", "conf", "json", "jsonc", "sshconfig", "js", "md", "lua"},
  callback = set_tab2,
})
