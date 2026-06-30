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
    config = function()
      require("persistence").setup()
      vim.keymap.set("n", "<leader>rs", [[<cmd>lua require("persistence").load()<cr>]])
      vim.keymap.set("n", "<leader>rS", [[<cmd>lua require("persistence").select()<cr>]])
      vim.keymap.set("n", "<leader>rl", [[<cmd>lua require("persistence").load({ last = true})<cr>]])
      vim.keymap.set("n", "<leader>rd", [[<cmd>lua require("persistence").stop()<cr>]])
    end
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
    config = true,
  },
  -- {
  --   "folke/flash.nvim",
  --   config = function()
  --     require("flash").setup()
  --     vim.keymap.set({ "n", "x", "o" }, "s",
  --       function()
  --         require("flash").jump({
  --           search = {
  --             mode = function(str)
  --               return "\\<" .. str
  --             end,
  --           },
  --         })
  --       end
  --     )
  --     vim.keymap.set({ "n", "x", "o" }, "S",
  --       function()
  --         require("flash").treesitter()
  --       end
  --     )
  --     vim.keymap.set({ "o" }, "r",
  --       function()
  --         require("flash").remote()
  --       end
  --     )
  --     vim.keymap.set({ "o", "x" }, "R",
  --       function()
  --         require("flash").treesitter_search()
  --       end
  --     )
  --   end,
  -- },
  {
    "kamykn/spelunker.vim",
    event = "VeryLazy",
    config = function()
      vim.g.spelunker_check_type = 2
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
  { -- enhance textobjects(a, i)
    'echasnovski/mini.ai',
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = true,
  },
  {
    "kylechui/nvim-surround",
    version = "^4.0.0",
    event = "VeryLazy",
  },
  {
    "s1n7ax/nvim-window-picker",
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
