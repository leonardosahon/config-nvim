return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      gopls = {
        settings = {
          gopls = {
            usePlaceholders = false,
            completeUnimported = true,
            -- Enable hints for composite literals
            hints = {
              compositeLiteralFields = true, -- Shows field names in struct literals
              compositeLiteralTypes = true, -- Shows type info for struct literals
            },
          },
        },
      },
    },
  },
}
