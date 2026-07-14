local option = vim.opt
local buffer = vim.b
local global = vim.g

--= Option Settings
--== Edit
option.backspace = { "indent", "eol", "start" }
option.expandtab = true
option.tabstop = 4
option.shiftwidth = 4
option.softtabstop = 4
option.shiftround = true
option.autoindent = true
option.smartindent = true

--== Appearance
option.number = true
option.relativenumber = true
option.showmode = true
option.wildmenu = true
option.hlsearch = false
option.ignorecase = true
option.smartcase = true
option.completeopt = { "menu", "menuone" }
option.cursorline = true
option.termguicolors = true
option.signcolumn = "yes"
option.title = true
option.wrap = false
option.list = true
option.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

--== File
option.autoread = true
option.swapfile = false
option.backup = false
option.undofile = true
option.undodir = vim.fn.expand('$HOME/.local/share/nvim/undo')
option.exrc = true

--== Misc
option.updatetime = 250
option.mouse = "a"
option.splitright = true

--= Buffer Settings
buffer.fileenconding = "utf-8"

--= Global Settings
global.mapleader = " "
global.maplocalleader = "\\"
