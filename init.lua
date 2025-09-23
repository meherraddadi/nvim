local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Set clipboard to use system clipboard
vim.opt.clipboard = "unnamedplus" -- Use "+y and "+p like vim
vim.opt.termguicolors = true

-- Configure terraform filetype detection
require("terraform-filetype")
require("debug-terraform")

require("vim-options")
require("lazy").setup("plugins")
