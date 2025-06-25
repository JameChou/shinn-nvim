return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'lua Snacks.picker.files()',
            key = 'f',
          },
          {
            desc = ' Projects',
            group = 'DiagnosticHint',
            action = 'lua Snacks.picker.projects()',
            key = 'a',
          },
          {
            desc = ' Recent Files',
            group = 'Number',
            action = 'lua Snacks.picker.recent()',
            key = 'd',
          },
        },
      },
    }
  end,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
}
