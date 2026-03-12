return {
  'nvim-tree/nvim-web-devicons',
  lazy = false,
  opts = {
    default = true,
    color_icons = true,
    strict = true,
    override_by_extension = {
      lua = { icon = '', color = '#d79921', name = 'Lua' },
      vim = { icon = '', color = '#fabd2f', name = 'Vim' },
      md = { icon = '', color = '#83a598', name = 'Markdown' },
      json = { icon = '', color = '#8ec07c', name = 'Json' },
      toml = { icon = '', color = '#fe8019', name = 'Toml' },
      yml = { icon = '', color = '#8ec07c', name = 'Yml' },
      yaml = { icon = '', color = '#8ec07c', name = 'Yaml' },
      lock = { icon = '󰌾', color = '#fb4934', name = 'Lock' },
      sh = { icon = '', color = '#b8bb26', name = 'Shell' },
      zsh = { icon = '', color = '#b8bb26', name = 'Zsh' },
    },
    override_by_filename = {
      ['.gitignore'] = { icon = '', color = '#928374', name = 'GitIgnore' },
      ['lazy-lock.json'] = { icon = '󰒲', color = '#fabd2f', name = 'LazyLock' },
      ['init.lua'] = { icon = '', color = '#d79921', name = 'InitLua' },
      ['README.md'] = { icon = '', color = '#83a598', name = 'Readme' },
      ['LICENSE.md'] = { icon = '', color = '#8ec07c', name = 'License' },
    },
  },
}
