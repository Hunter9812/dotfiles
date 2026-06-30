local option = vim.opt
local buffer = vim.b
local global = vim.g

-- Option Settings --
option.showmode = true
option.backspace = { "indent", "eol", "start" }
option.expandtab = true
option.tabstop = 4
option.shiftwidth = 4
option.softtabstop = 4
option.shiftround = true
option.autoindent = true
option.smartindent = true
option.number = true
option.relativenumber = true
option.wildmenu = true
option.hlsearch = false
option.ignorecase = true
option.smartcase = true
option.completeopt = { "menu", "menuone" }
option.cursorline = true
option.termguicolors = true
option.signcolumn = "yes"
option.autoread = true
option.title = true
option.swapfile = false
option.backup = false
option.updatetime = 50
option.mouse = "a"
option.undofile = true
option.undodir = vim.fn.expand('$HOME/.local/share/nvim/undo')
option.exrc = true
option.wrap = false
option.splitright = true

-- Buffer Settings --
buffer.fileenconding = "utf-8"

-- Global Settings --
global.mapleader = " "
global.clipborad = "unnamedplus"

-- Key Mappings --
vim.keymap.set("n", "<C-s>", "ciw")

vim.keymap.set("n", "<leader>w",  "<Cmd>w<CR>")
vim.keymap.set("n", "<leader>q",  "<Cmd>bd<CR>")
vim.keymap.set("n", "<leader>Q",  "<Cmd>bd!<CR>")
vim.keymap.set("n", "<leader>d",  "<Cmd>diffthis<CR>")
vim.keymap.set("n", "<Tab>",      "<Cmd>bnext<CR>")
vim.keymap.set("n", "<S-Tab>",    "<Cmd>bprevious<CR>")
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>")
vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>")

vim.keymap.set("v", "K", ":m '<-2<CR>gv-gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv-gv")

vim.keymap.set({ "v", "n" }, "<leader>y", "\"+y")
vim.keymap.set({ "v", "n" }, "<leader>p", "\"+p")

vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>")

-- Autocmd --
local function set_tab2()
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "bash", "zsh", "conf", "json", "jsonc", "sshconfig", "js", "md", "lua"},
  callback = set_tab2,
})
