return {
  {
    "folke/tokyonight.nvim",
    dependencies = {
      "nvim-lualine/lualine.nvim",
      "nvim-tree/nvim-web-devicons",
      "utilyre/barbecue.nvim",
      "SmiteshP/nvim-navic"
    },
    config = function()
      require("tokyonight").setup({
        style = "storm",
        light_style = "day",
        transparent = true,
      })
      vim.cmd[[colorscheme tokyonight]]
      require('lualine').setup({
        options = {
          theme = 'tokyonight'
        },
      })
      require('barbecue').setup {
        theme = 'tokyonight',
      }
    end
  }
}
