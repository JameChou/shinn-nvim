return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
  opts = {},
  config = function(_, opts)
    require('render-markdown').setup(opts)
    vim.keymap.set('n', '<leader>ro', '<cmd>RenderMarkdown buf_enable<CR>', { desc = "Enable RenderMarkdown" })
    vim.keymap.set('n', '<leader>rc', '<cmd>RenderMarkdown buf_disable<CR>', { desc = "Enable RenderMarkdown" })
  end,
}
