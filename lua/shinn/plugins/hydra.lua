return {
  "anuvyklack/hydra.nvim",
  config = function()
    local Hydra = require("hydra")
    Hydra({
      name = 'Windows',
      hint = [[
Resize Mode
h ←  j ↓  k ↑  l →
]],
      config = {
        invoke_on_body = true,
        hint = {
          border = 'rounded',
          offset = -1
        }
      },
      mode = 'n',
      body = '<leader>rr',
      heads = {
        { "h",     "<cmd>vertical resize -5<cr>" },
        { "l",     "<cmd>vertical resize +5<cr>" },
        { "j",     "<cmd>resize +3<cr>" },
        { "k",     "<cmd>resize -3<cr>" },
        { "<Esc>", nil,                          { exit = true } },
      },
    })
  end
}
