return {
  {
    "rhysd/accelerated-jk",
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)" },
      { "k", "<Plug>(accelerated_jk_gk)" },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      enable_check_bracket_line = true,
    },
  },
  {
    "ethanholz/nvim-lastplace",
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { -- enhance textobjects(a, i)
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "^4.0.0",
    event = "VeryLazy",
  },
  {
    "easymotion/vim-easymotion",
    event = "VeryLazy",
  },
  {
    's1n7ax/nvim-window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require("window-picker").setup({
        filter_rules = {
          include_current_win = true,
          bo = {
            filetype = { "fidget", "neo-tree" }
          }
        }
      })
      vim.keymap.set("n",
        "<c-w>p",
        function()
          local window_number = require('window-picker').pick_window()
          if window_number then vim.api.nvim_set_current_win(window_number) end
        end
      )
    end
  },
}
