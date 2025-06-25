local pip_args
local proxy = os.getenv 'PIP_PROXY'
if proxy then
  pip_args = { '--proxy', proxy }
else
  pip_args = {}
end

return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    event = { 'BufReadPost', 'BufNewFile', 'VimEnter' },
    opts = {},
    config = function()
      require('mason').setup {
        pip = {
          upgrade_pip = false,
          install_args = pip_args,
        },
        ui = {
          border = 'single',
          width = 0.7,
          height = 0.7,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "yioneko/nvim-vtsls",
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "vtsls",
          "vue_ls",
          "eslint",
          "tailwindcss",
          "emmet_language_server",
          "lua_ls",
        },
        automatic_enable = true,
        automatic_installation = false,
      })
      -- vim.lsp.config("vtsls", {
      --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      --   settings = {
      --     vtsls = { tsserver = { globalPlugins = {} } },
      --     typescript = {
      --       inlayHints = {
      --         parameterNames = { enabled = "literals" },
      --         parameterTypes = { enabled = true },
      --         variableTypes = { enabled = true },
      --         propertyDeclarationTypes = { enabled = true },
      --         functionLikeReturnTypes = { enabled = true },
      --         enumMemberValues = { enabled = true },
      --       },
      --     },
      --   },
      --   before_init = function(_, config)
      --     table.insert(config.settings.vtsls.tsserver.globalPlugins, {
      --       name = "@vue/typescript-plugin",
      --       location = vim.fn.expand(
      --         "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
      --       ),
      --       languages = { "vue" },
      --       configNamespace = "typescript",
      --       enableForWorkspaceTypeScriptVersions = true,
      --     })
      --   end,
      --   on_attach = function(client)
      --     client.server_capabilities.documentFormattingProvider = false
      --     client.server_capabilities.documentRangeFormattingProvider = false
      --   end,
      -- })
    end,
  },
}
