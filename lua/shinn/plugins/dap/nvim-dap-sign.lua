sign_module = {}
function sign_module.set_sign()
  vim.cmd('highlight DapStoppedLine guibg=#442222 ctermbg=236')

  vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '❌', texthl = '', linehl = '', numhl = '' })

  vim.fn.sign_define('DapStopped', {
    text = '➡️',
    texthl = 'DapStoppedSign',
    linehl = 'DapStoppedLine', -- 整行暗红色背景
    numhl = ''
  })
end

return sign_module
