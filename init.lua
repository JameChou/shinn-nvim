-- Load keymaps configuration file.
require 'shinn.configs.keymaps'
-- Load vim option configuration file.
require 'shinn.configs.options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Lazy options
require('lazy').setup({
  'tpope/vim-sleuth',

  -- luvit-meta
  { 'Bilal2453/luvit-meta', lazy = true },

  -- require 'shinn.plugins.themes.tokynight',
  -- require 'shinn.plugins.telescope',
  -- require 'shinn.plugins.cmp',
  -- require 'shinn.plugins.fzf',
  -- require 'shinn.plugins.neoscroll',
  -- require 'shinn.plugins.smear-cursor',
  -- require 'shinn.plugins.neo-tree',

  -- theme configuration begins
  require 'shinn.plugins.themes.catppuccin',

  -- my plugins
  require 'shinn.plugins.vim-table-mode',
  require 'shinn.plugins.vim-lsp',
  require 'shinn.plugins.auto-format',
  require 'shinn.plugins.which-keys',
  require 'shinn.plugins.blink-cmp',
  require 'shinn.plugins.mini',
  require 'shinn.plugins.todo-comments',
  require 'shinn.plugins.markdown-view',
  require 'shinn.plugins.comment',
  require 'shinn.plugins.winbar',
  require 'shinn.plugins.easy-align',
  require 'shinn.plugins.dashboard',
  require('shinn.plugins.vista').Config,
  require('shinn.plugins.dap').Config,
  require 'shinn.plugins.gitsigns',
  require 'shinn.plugins.nvim-java',
  require 'shinn.plugins.hlchunk',
  require 'shinn.plugins.flash',
  require 'shinn.plugins.lualine',
  require 'shinn.plugins.oil',
  require 'shinn.plugins.yazi',
  require 'shinn.plugins.autopairs',
  require 'shinn.plugins.lsp-config',
  require 'shinn.plugins.nvim-treesitter',
  require 'shinn.plugins.vim-visual-multi',
  require 'shinn.plugins.snacks',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
