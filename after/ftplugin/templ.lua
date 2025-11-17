vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.templ",
  callback = function()
    vim.fn.jobstart({ "templ", "generate" }, { detach = true })
  end,
})
