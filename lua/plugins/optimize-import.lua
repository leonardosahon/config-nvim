return {
  -- Configure LSP servers with auto-organize imports
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Svelte configuration
        svelte = {
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                if vim.api.nvim_buf_is_valid(bufnr) then
                  vim.lsp.buf.code_action({
                    context = {
                      only = { "source.organizeImports" },
                      diagnostics = {},
                    },
                    apply = true,
                  })
                  vim.wait(50)
                end
              end,
            })
          end,
        },
        -- TypeScript configuration
        vtsls = {
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                if vim.api.nvim_buf_is_valid(bufnr) then
                  vim.lsp.buf.code_action({
                    context = {
                      only = { "source.organizeImports" },
                      diagnostics = {},
                    },
                    apply = true,
                  })
                  vim.wait(50)
                end
              end,
            })
          end,
        },
      },
    },
  },

  -- Configure conform.nvim for formatting with Prettier
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        svelte = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
      },
    },
  },
}
