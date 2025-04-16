-- Load keymaps configuration file.
require 'shinn.configs.keymaps'
-- Load vim option configuration file.
require 'shinn.configs.options'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
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
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth',

  -- luvit-meta
  { 'Bilal2453/luvit-meta', lazy = true },

  require 'shinn.plugins.themes.tokynight',
  -- require 'shinn.plugins.themes.catppuccin',

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'shinn.plugins.vim-table-mode',
  require 'shinn.plugins.git',
  require 'shinn.plugins.vim-lsp',
  require 'shinn.plugins.telescope',
  require 'shinn.plugins.auto-format',
  require 'shinn.plugins.which-keys',
  require 'shinn.plugins.auto-complete',
  require 'shinn.plugins.mini',
  require 'shinn.plugins.todo-comments',
  require 'shinn.plugins.nvim-treesitter',
  require 'shinn.plugins.vim-instant-markdown',
  require 'shinn.plugins.comment',
  require 'shinn.plugins.winbar',
  require 'shinn.plugins.easy-align',
  require 'shinn.plugins.dashboard',
  require 'shinn.plugins.fzf',
  require('shinn.plugins.vista').Config,
  require('shinn.plugins.dap').Config,
  require 'shinn.plugins.nvim-java',
  require 'shinn.plugins.hlchunk',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  -- config
  require 'shinn.plugins.lsp-config',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
