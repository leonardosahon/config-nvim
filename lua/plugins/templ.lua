return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")

      -- Register the templ LSP
      lspconfig.templ.setup({
        cmd = { "templ", "lsp" },
        filetypes = { "templ" },
        root_dir = lspconfig.util.root_pattern("go.work", "go.mod", "go.sum", ".git"),
      })
    end,
  },

  -- Optional: Treesitter highlighting for templ
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "templ", "html", "go" })
    end,
  },
}
