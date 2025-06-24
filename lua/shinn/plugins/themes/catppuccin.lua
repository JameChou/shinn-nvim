return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      styles = {       -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = {}, -- Change the style of comments
        conditionals = {},
        loops = {},
        functions = { 'italic' },
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = { 'italic' },
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
