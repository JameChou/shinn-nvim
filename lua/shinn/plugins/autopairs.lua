-- autopairs
-- https://github.com/windwp/nvim-autopairs
return {
  'altermo/ultimate-autopair.nvim',
  event = { 'InsertEnter', 'CmdlineEnter' },
  branch = 'v0.6', --recommended as each new version will have breaking changes
  opts = {
    --Config goes here
  },
}
-- return {
--   'windwp/nvim-autopairs',
--   event = 'InsertEnter',
--   config = function()
--     require('nvim-autopairs').setup {}
--     -- TODO: how to work with the blink-cmp
--   end,
-- }
