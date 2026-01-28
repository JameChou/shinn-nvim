return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('nvim-treesitter').install({
      "c", "cpp", "cmake", "comment", "go", "java", "javascript",
      "jsx", "lua", "ledger", "markdown", "markdown_inline",
      "python", "rust", "typescript", "tsx", "vim", "vue", "zsh"
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "cpp", "cmake", "go", "java", "javascript", "javascriptreact", "ledger",
        "lua", "markdown", "python", "rust", "typescript", "typescriptreact", "vue"
      },
      callback = function()
        vim.treesitter.start()
      end,
      group = nvimrc_augroup
    })
  end,
}
