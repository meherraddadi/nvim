vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "none"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Close buffer
vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>Q', ':bd!<CR>', { desc = 'Force close buffer' })
vim.keymap.set('n', '<leader>w', ':enew<CR>', { desc = 'New buffer in window' })
vim.keymap.set('n', '<leader>bo', ':%bd|e#<CR>', { desc = 'Close other buffers' })

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true

