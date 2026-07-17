local map = vim.keymap.set

local function close_buffer(force)
  if vim.fn.getcmdwintype() ~= "" then
    vim.cmd("quit")
    return
  end

  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  if #listed <= 1 then
    vim.cmd(force and 'quit!' or 'quit')
  else
    vim.cmd(force and "bd!" or "bd")
  end
end

--= Navigation
map('n', '<Tab>',      '<Cmd>bnext<CR>',     { desc = 'Next buffer' })
map('n', '<S-Tab>',    '<Cmd>bprevious<CR>', { desc = 'Previous buffer' })

--= File
map('n', '<leader>w',  '<Cmd>w<CR>',         { desc = 'Save file' })
map('n', '<leader>dh', '<Cmd>diffthis<CR>',  { desc = 'Diff here (current window)' })
map('n', '<leader>q', function() close_buffer(false) end, { desc = 'Close buffer' })
map('n', '<leader>Q', function() close_buffer(true) end,  { desc = 'Force close buffer' })

--= Editing
map('v', 'K', ":m '<-2<CR>gv=gv",            { desc = 'Move selection up' })
map('v', 'J', ":m '>+1<CR>gv=gv",            { desc = 'Move selection down' })
map('n', '<C-M-Up>',   'mzyyP`zk',           { desc = 'Duplicate line above' })
map('n', '<C-M-Down>', 'mzyyP`z',            { desc = 'Duplicate line below' })
map({ 'v', 'n' }, '<leader>y', '\"+y',       { desc = 'Copy to clipboard' })
map({ 'v', 'n' }, '<leader>p', '\"+p',       { desc = 'Paste from clipboard' })

--== Behavior
-- Keep yank register when pasting over selection.
-- Alternative: use `"0p` to explicitly paste from the yank register.
map('x', 'p', '"_dP', { desc = 'Paste without overwriting register' })

-- Keep selection after indenting.
map('x', '<', '<gv',  { desc = 'Indent left and keep selection' })
map('x', '>', '>gv',  { desc = 'Indent right and keep selection' })
