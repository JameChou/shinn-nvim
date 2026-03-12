sign_module = {}
function sign_module.set_sign()
  vim.api.nvim_set_hl(0, 'DapStoppedLine', { link = 'CursorLine' })
  vim.api.nvim_set_hl(0, 'DapStoppedSign', { link = 'DiagnosticWarn' })
  vim.api.nvim_set_hl(0, 'DapBreakpointSign', { link = 'DiagnosticError' })
  vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { link = 'DiagnosticInfo' })

  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpointSign', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' })

  vim.fn.sign_define('DapStopped', {
    text = '󰁕',
    texthl = 'DapStoppedSign',
    linehl = 'DapStoppedLine',
    numhl = 'DapStoppedSign',
  })
  vim.fn.sign_define('DapBreakpointCondition', {
    text = '󰟃',
    texthl = 'DapBreakpointCondition',
    linehl = '',
    numhl = 'DapBreakpointCondition',
  })
end

return sign_module
