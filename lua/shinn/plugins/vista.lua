local M = {}

M.Config = {
  'liuchengxu/vista.vim',

  config = function()
    vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
    vim.g.vista_default_executive = 'ctags'

    vim.keymap.set('n', 'T', '<cmd>Vista!!<CR>', { desc = '[T]oggle tag trees' })
  end,
}

return M
