-- return {
--   'nvim-java/nvim-java',
--   config = function()
--     require('java').setup()
--     require('lspconfig').jdtls.setup {}
--   end,
-- }

-- java jdtls simple configuration
return {
  'mfussenegger/nvim-jdtls',
  dependencies = 'saghen/blink.cmp',
  config = function()
    require('jdtls').start_or_attach {
      cmd = {
        vim.fn.expand '$HOME/.local/share/nvim/mason/bin/jdtls',
        ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand '$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
      },
      capabilities = require('blink-cmp').get_lsp_capabilities(),
      bundles = vim.split(vim.fn.glob('$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar', 1), '\n'),
    }
  end,
}
