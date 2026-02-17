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
            hints = {
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
            },
          },
        },
      },
      -- Tailwindcss enabled for CSS autocomplete
      tailwindcss = {},
      svelte = {
        settings = {
          svelte = {
            plugin = {
              svelte = {
                -- Disable runes legacy mode code lens to prevent false positives
                runesLegacyModeCodeLens = { enable = false },
              },
            },
          },
        },
      },
    },
    -- Reduce file watching to prevent EMFILE errors
    filewatch = {
      enabled = false,
    },
  },
  keys = {
    {
      "<leader>oi",
      function()
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" } },
          apply = true,
        })
      end,
      desc = "Organize Imports",
    },
  },
}
