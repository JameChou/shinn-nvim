key_module = {}

-- set dap keymap
function key_module.key_set()
  vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = " Start/Continue" })
  vim.keymap.set('n', '<leader>ds', function() require('dap').continue() end, { desc = " Start/Continue" })

  vim.keymap.set('n', '<F6>', function() require('dap').step_over() end, { desc = " Step over" })
  vim.keymap.set('n', '<leader>dd', function() require('dap').step_over() end, { desc = " Step over" })

  vim.keymap.set('n', '<F3>', function() require('dap').step_into() end, { desc = ' Step into' })
  vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = ' Step into' })

  vim.keymap.set('n', '<F4>', function() require('dap').step_out() end, { desc = " Step out" })
  vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end, { desc = " Step out" })

  vim.keymap.set('n', '<leader>dc', function() require('dap').run_to_cursor() end, { desc = "Dap: Run to cursor" })
  vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end,
    { desc = 'Dap: Set a break point' })

  vim.keymap.set('n', '<leader>dB', function()
    local input = vim.fn.input 'Condition for breakpoint:'
    require('dap').set_breakpoint(input)
  end, { desc = "Dap: Condition break point" })

  vim.keymap.set('n', '<Leader>dr', function()
    require('dap').repl.open()
  end, { desc = 'Dap: repl run ' })

  vim.keymap.set('n', '<Leader>dl', function()
    require('dap').run_last()
  end, { desc = 'Dap: run last' })

  vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = 'Dap: ui hover' })
end

return key_module
