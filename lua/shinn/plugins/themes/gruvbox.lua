return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    local palette = require('gruvbox').palette

    require('gruvbox').setup({
      terminal_colors = false, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "",  -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        Normal = { fg = palette.light1, bg = palette.dark0 },
        NormalNC = { fg = palette.light1, bg = palette.dark0 },
        SignColumn = { bg = palette.dark0 },
        NormalFloat = { fg = palette.light1, bg = palette.dark0 },
        FloatBorder = { fg = palette.dark3, bg = palette.dark0 },
        FloatTitle = { fg = palette.bright_yellow, bg = palette.dark0, bold = true },
        WinSeparator = { fg = palette.dark2, bg = palette.dark0 },
        Pmenu = { fg = palette.light1, bg = palette.dark1 },
        PmenuSel = { fg = palette.light1, bg = palette.dark2, bold = true },
        CursorLineNr = { fg = palette.bright_yellow, bold = true },

        DiagnosticSignError = { fg = palette.bright_red, bg = palette.dark0 },
        DiagnosticSignWarn = { fg = palette.bright_yellow, bg = palette.dark0 },
        DiagnosticSignInfo = { fg = palette.bright_blue, bg = palette.dark0 },
        DiagnosticSignHint = { fg = palette.bright_aqua, bg = palette.dark0 },
        DiagnosticVirtualTextError = { fg = palette.neutral_red, bg = palette.dark1 },
        DiagnosticVirtualTextWarn = { fg = palette.neutral_yellow, bg = palette.dark1 },
        DiagnosticVirtualTextInfo = { fg = palette.neutral_blue, bg = palette.dark1 },
        DiagnosticVirtualTextHint = { fg = palette.neutral_aqua, bg = palette.dark1 },

        DashboardHeader = { fg = palette.bright_yellow, bold = true },
        DashboardDesc = { fg = palette.light2 },
        DashboardShortcut = { fg = palette.bright_orange, bold = true },
        DashboardKey = { fg = palette.bright_green, bold = true },
        DashboardIcon = { fg = palette.bright_aqua },

        NeoTreeNormal = { bg = palette.dark0_soft },
        NeoTreeNormalNC = { bg = palette.dark0_soft },
        NeoTreeFloatBorder = { fg = palette.dark3, bg = palette.dark0_soft },
        NeoTreeTitleBar = { fg = palette.dark0, bg = palette.bright_yellow, bold = true },
      },
      dim_inactive = false,
      transparent_mode = false,
    })
    vim.cmd('colorscheme gruvbox')
  end,
  opts = {},
}
