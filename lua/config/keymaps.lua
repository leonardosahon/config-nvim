-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- MY KEY BINDINGS

vim.keymap.set("n", "<leader><space>", "<leader>fF", { desc = "Find Files (cwd)", remap = true })

vim.keymap.set("n", "<CR>", function()
  vim.fn.append(vim.fn.line(".") - 1, "")
end, { desc = "Add new line above", silent = true })

-- vim.keymap.set({"n", "i"}, "<leader><space>", "<leader>fF", { desc = "Find Files (cwd)", remap = true })
