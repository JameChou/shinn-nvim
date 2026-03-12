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
          { desc = '󰊳 Update', group = 'DashboardShortcut', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = 'DashboardIcon',
            desc = 'Files',
            group = 'DashboardDesc',
            action = 'lua Snacks.picker.files()',
            key = 'f',
          },
          {
            desc = ' Projects',
            group = 'DashboardDesc',
            action = 'lua Snacks.picker.projects()',
            key = 'a',
          },
          {
            desc = ' Recent Files',
            group = 'DashboardDesc',
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
