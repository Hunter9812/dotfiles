return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require('illuminate').configure()
    end
  },
}
