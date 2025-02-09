return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  config = function()
    vim.keymap.set('n', '<leader>F', "<cmd>lua require('fzf-lua').files({cwd='./'})<cr>", { desc = 'Fzf files' })
  end,
}
