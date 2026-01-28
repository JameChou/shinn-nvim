-- Markdown real-time preview plugin.
-- For `plugins/markview.lua` users.
-- markdown preview in web
return {
  enable = false,
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
  config = function()
    vim.g.mkdp_auto_close = 0
  end,
}
