return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      disable_inline_completion = true, -- disables the ghost text
      disable_keymaps = true, -- we'll define our own
    })
  end,
}
