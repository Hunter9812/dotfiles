local map = vim.keymap.set

map('n', '<leader>w',  '<Cmd>w<CR>',         { desc = 'Save file' })
map('n', '<leader>q',  '<Cmd>bd<CR>',        { desc = 'Close buffer'})
map('n', '<leader>Q',  '<Cmd>bd!<CR>',       { desc = 'Force close buffer' })

map('n', '<leader>dh', '<Cmd>diffthis<CR>',  { desc = 'Diff here (current window)' })

map('n', '<Tab>',      '<Cmd>bnext<CR>',     { desc = 'Next buffer' })
map('n', '<S-Tab>',    '<Cmd>bprevious<CR>', { desc = 'Previous buffer' })

map('v', 'K', ":m '<-2<CR>gv=gv",            { desc = 'Move selection up' })
map('v', 'J', ":m '>+1<CR>gv=gv",            { desc = 'Move selection down' })

map({ 'v', 'n' }, '<leader>y', '\"+y',       { desc = 'Copy to clipboard' })
map({ 'v', 'n' }, '<leader>p', '\"+p',       { desc = 'Paste from clipboard' })
