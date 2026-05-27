-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("clear_undo_on_delete", { clear = true }),
  desc = "Clear undo history when a buffer is deleted",
  callback = function(args)
    vim.bo[args.buf].undolevels = -1
  end,
})
