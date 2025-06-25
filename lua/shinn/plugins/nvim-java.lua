-- java jdtls simple configuration
return {
  'mfussenegger/nvim-jdtls',
  dependencies = 'saghen/blink.cmp',
  opts = {
    cmd = {
      vim.fn.expand '$HOME/.local/share/nvim/mason/bin/jdtls',
      ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand '$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
    },
    -- root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.idea', '.settings', 'mvnw' }, { upward = true })[1]),
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.idea', '.git', 'mvnw' }, { upward = true })[1]),
    bundles = vim.split(vim.fn.glob('$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar', 1), '\n'),
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = function()
        -- prints and pcall are there only to give quick feedback if it works.
        -- print 'Starting JDTLS...'
        opts.capabilities = require('blink-cmp').get_lsp_capabilities()
        local success, result = pcall(require('jdtls').start_or_attach, opts)
        if not success then
          print('Error starting JDTLS: ' .. tostring(result))
        end
      end,
    })
  end,
}
