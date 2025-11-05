return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim",
  },
  opts = function(_, opts)
    local cmp = require("cmp")

    -- Disable ghost text
    opts.experimental = opts.experimental or {}
    opts.experimental.ghost_text = false

    opts.formatting = {
      format = function(entry, vim_item)
        vim_item.mode = "icon"
        vim_item.menu = ({
          buffer = "<BUFF>",
          nvim_lsp = "<LSP>",
          snippets = "<SNIP>",
          nvim_lua = "<LUA>",
          path = "<PATH>",
        })[entry.source.name] or ("<" .. entry.source.name .. ">")

        return vim_item
      end,
    }

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      -- Maintain enter key's normal behaviour
      -- ["<CR>"] = cmp.mapping(function(fallback)
      --   fallback()
      -- end, { "i" }),

      --Modify how snippets are inserted
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            fallback()
            return
          end

          -- fallback: standard cmp confirm if no textEdit provided
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { "i", "s" }),

      -- Close popup with ctrl+q
      ["<C-q>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.close()
        else
          fallback()
        end
      end, { "i", "s" }),
    })
  end,
}
