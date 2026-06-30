return {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- optional but recommended
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      }
    }
    require('telescope').load_extension('fzf')
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Search files in project' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Search text in project (live grep)' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Switch between open buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Search Neovim help documentation' })
    vim.keymap.set('n', '<leader>?',  builtin.oldfiles,   { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
  end
}
