local function set_tab2()
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'markdown', 'lua', 'javascript', 'typescript', 'json', 'css',
    'conf', 'dosini', 'jsonc', 'yaml', 'toml',
    'sh', 'zsh', 'nu', 'sshconfig', 'gitconfig', 'dockerfile',
  },
  callback = set_tab2,
})
