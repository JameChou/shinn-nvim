key_module = {}

-- set dap keymap
function key_module.key_set()
  vim.keymap.set('n', '<F5>', function()
    require('dap').continue()
  end)

  vim.keymap.set('n', '<F6>', function()
    require('dap').step_over()
  end)

  vim.keymap.set('n', '<Leader>b', function()
    require('dap').toggle_breakpoint()
  end, { desc = 'Toggle a break point' })

  vim.keymap.set('n', '<Leader>B', function()
    require('dap').set_breakpoint()
  end, { desc = 'Set a break point' })

  vim.keymap.set('n', '<Leader>dr', function()
    require('dap').repl.open()
  end, { desc = 'Dap repl run ' })

  vim.keymap.set('n', '<Leader>dl', function()
    require('dap').run_last()
  end, { desc = 'Dap run last' })

  vim.keymap.set('n', '<leader>do', function()
    require('dapui').open()
  end, { desc = 'Dap ui open' })

  vim.keymap.set('n', '<leader>dc', function()
    require('dapui').close()
  end, { desc = 'Dap ui close' })

  vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = 'Dap ui hover' })

  vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
  end, { desc = 'Dap ui preview' })

  vim.keymap.set('n', '<Leader>df', function()
    local widgets = require 'dap.ui.widgets'
    widgets.centered_float(widgets.frames)
  end, { desc = 'Dap ui center float [F]rames' })

  vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require 'dap.ui.widgets'
    widgets.centered_float(widgets.scopes)
  end, { desc = 'Dap ui center float [S]cope' })
end

return key_module
