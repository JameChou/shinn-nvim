return {
   "anuvyklack/hydra.nvim",
   dependencies = {
      "sindrets/winshift.nvim"
   },
   config = function()
      local Hydra = require('hydra')

      local cmd = require('hydra.keymap-util').cmd
      local pcmd = require('hydra.keymap-util').pcmd

      Hydra({
         name = 'Windows',
         hint = false,
         config = {
            invoke_on_body = true,
         },
         mode = 'n',
         body = '<leader>rr',
         heads = {
            { "h",     "<cmd>vertical resize -5<cr>" },
            { "l",     "<cmd>vertical resize +5<cr>" },
            { "j",     "<cmd>resize +3<cr>" },
            { "k",     "<cmd>resize -3<cr>" },
            { '=',     '<C-w>=',                     { desc = 'equalize' } },

            { 'H',     cmd 'WinShift left' },
            { 'J',     cmd 'WinShift down' },
            { 'K',     cmd 'WinShift up' },
            { 'L',     cmd 'WinShift right' },

            { 's',     pcmd('split', 'E36') },
            { '<C-s>', pcmd('split', 'E36'),         { desc = false } },
            { 'v',     pcmd('vsplit', 'E36') },
            { '<C-v>', pcmd('vsplit', 'E36'),        { desc = false } },

            { 'w',     '<C-w>w',                     { exit = true, desc = false } },
            { '<C-w>', '<C-w>w',                     { exit = true, desc = false } },

            { 'o',     '<C-w>o',                     { exit = true, desc = 'remain only' } },

            { 'c',     pcmd('close', 'E444') },
            { '<C-c>', pcmd('close', 'E444'),        { desc = false } },
            { '<C-q>', pcmd('close', 'E444'),        { desc = false } },

            { '<Esc>', nil,                          { exit = true, desc = false } },
         }
      })
   end
}
