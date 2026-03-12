return {
   "anuvyklack/hydra.nvim",
   config = function()
      local Hydra = require("hydra")

      Hydra({
         name = "Resize",
         mode = "n",
         body = "<leader>rr",
         config = {
            hint = false,
         },
         heads = {
            { "h",     "<cmd>vertical resize -5<cr>" },
            { "l",     "<cmd>vertical resize +5<cr>" },
            { "j",     "<cmd>resize +3<cr>" },
            { "k",     "<cmd>resize -3<cr>" },

            -- 必须有 exit
            { "<Esc>", nil,                          { exit = true } },
            { "q",     nil,                          { exit = true } },
         },
      })
   end
}
