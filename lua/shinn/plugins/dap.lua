local DAP = {}

DAP.Config = {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- dap ui
    require 'shinn.plugins.dap.nvim-dap-ui',
    { 'nvim-neotest/nvim-nio' },
    require 'shinn.plugins.dap.nvim-dap-virtual-text',
    { "jay-babu/mason-nvim-dap.nvim" },

  },
  config = function()
    -- load keymap settings
    require('shinn.plugins.dap.nvim-dap-keymap').key_set()
    -- load sign font settings
    require('shinn.plugins.dap.nvim-dap-sign').set_sign()

    -- begin language dap setting

    -- C/C++ lldb
    -- require('shinn.plugins.dap.lanuage.nvim-dap-cc').setup()
    -- end language dap setting

    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb" },
      handlers = {
        function(config)
          -- 使用默认处理程序
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    })
  end,
}
return DAP
