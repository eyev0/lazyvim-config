-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.iskeyword:append("-")
vim.wo.spell = false
vim.opt.spelllang = { "en", "ru_ru" }
vim.opt.spelloptions = ""

vim.g.autoformat = false

vim.opt.swapfile = false
vim.opt.undofile = true
-- not working
-- vim.opt.mouse = "nvic"

-- snacks.nvim
vim.g.snacks_scroll = false
