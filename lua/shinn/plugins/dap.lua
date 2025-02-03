local DAP = {}

DAP.Config = {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- dap ui
    require 'shinn.plugins.dap.nvim-dap-ui',
    { 'nvim-neotest/nvim-nio' },
    require 'shinn.plugins.dap.nvim-dap-virtual-text',
  },
  config = function()
    -- load keymap settings
    require('shinn.plugins.dap.nvim-dap-keymap').key_set()
    -- load sign font settings
    require('shinn.plugins.dap.nvim-dap-sign').set_sign()

    -- begin language dap setting

    -- C/C++ lldb
    require('shinn.plugins.dap.lanuage.nvim-dap-cc').setup()
    -- end language dap setting
  end,
}

return DAP
