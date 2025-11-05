-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- MY Options

-- Disable Neovim’s legacy SQL completion that causes the E117 errors
vim.g.loaded_sql_completion = 1
vim.g.omni_sql_no_default_maps = 1

vim.opt.undofile = false
