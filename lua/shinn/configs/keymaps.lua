-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>')
vim.keymap.set('i', '<C-s>', '<cmd>w<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Terminal 模式下的窗口切换（先退出 terminal 模式再切换）
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>1', '1gt', { desc = "Change to 1 tab" })
vim.keymap.set('n', '<leader>2', '2gt', { desc = "Change to 2 tab" })
vim.keymap.set('n', '<leader>3', '3gt', { desc = "Change to 3 tab" })
vim.keymap.set('n', '<leader>4', '4gt', { desc = "Change to 4 tab" })
vim.keymap.set('n', '<leader>5', '5gt', { desc = "Change to 5 tab" })
vim.keymap.set('n', '<leader>6', '6gt', { desc = "Change to 6 tab" })
vim.keymap.set('n', '<leader>7', '7gt', { desc = "Change to 7 tab" })
vim.keymap.set('n', '<leader>8', '8gt', { desc = "Change to 8 tab" })
vim.keymap.set('n', '<leader>9', '9gt', { desc = "Change to 9 tab" })

vim.keymap.set('n', '<M-b>', 'gT', { desc = "Switch to previous tab" })
vim.keymap.set('n', '<M-m>', 'gt', { desc = "Switch to next tab" })
