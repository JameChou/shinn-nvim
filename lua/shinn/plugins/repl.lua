return {
  "pranphy/nevl.nvim",
  config = function()
    require("nevl").setup()
    nevl = require('nevl')
    vim.keymap.set("v", "<leader><cr>", function()
      vim.fn.feedkeys([["+y]])
      nevl.run_in_repl({ "checkpoint_paste()" })
    end, { remap = true })
  end
}
