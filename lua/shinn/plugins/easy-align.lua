return {
  'junegunn/vim-easy-align',
  config = function()
    vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { desc = 'Easy Align' })
    vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { desc = 'Easy Align' })
  end,
}
