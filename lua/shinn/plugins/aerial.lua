return {
  'stevearc/aerial.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require('aerial').setup {
      layout = {
        default_direction = "prefer_right",
        min_width = 30
      },
    }

    vim.keymap.set('n', 'T', '<cmd>AerialToggle!<CR>', { desc = "Toggle Aerial" })
  end,
}
