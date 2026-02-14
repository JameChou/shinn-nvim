local DAP = {}

DAP.Config = {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- dap ui
    require 'shinn.plugins.dap.nvim-dap-ui',
    { "jay-babu/mason-nvim-dap.nvim" },
    require 'shinn.plugins.dap.nvim-dap-python',
  },
  config = function()
    -- load keymap settings
    require('shinn.plugins.dap.nvim-dap-keymap').key_set()
    -- load sign font settings
    require('shinn.plugins.dap.nvim-dap-sign').set_sign()


    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb" },
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    })
  end,
}
return DAP
