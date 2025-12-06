return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim",
    "supermaven-inc/supermaven-nvim",
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local cmp_types = require("cmp.types").lsp.CompletionItemKind

    -- Disable ghost text cleanly
    opts.experimental = opts.experimental or {}
    opts.experimental.ghost_text = false

    ---------------------------------------------------------------------------
    -- SOURCES (your original list but safely applied)
    ---------------------------------------------------------------------------
    opts.sources = {
      -- { name = "supermaven" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    }

    ---------------------------------------------------------------------------
    -- SORTING (unchanged)
    ---------------------------------------------------------------------------
    opts.sorting = {
      priority_weight = 2,
      comparators = {
        -- 1. PRIORITIZE FIELDS
        function(entry1, entry2)
          local kind1 = entry1:get_kind()
          local kind2 = entry2:get_kind()

          if kind1 == cmp_types.Field and kind2 ~= cmp_types.Field then
            return true
          end
          if kind2 == cmp_types.Field and kind1 ~= cmp_types.Field then
            return false
          end

          return nil
        end,

        -- Default comparators
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    }

    ---------------------------------------------------------------------------
    -- FORMATTING
    ---------------------------------------------------------------------------
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

    ---------------------------------------------------------------------------
    -- KEYMAPS
    ---------------------------------------------------------------------------
    opts.mapping = vim.tbl_extend("force", opts.mapping, {

      -- Your modified <Tab> snippet behavior
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            fallback()
            return
          end

          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { "i", "s" }),

      -----------------------------------------------------------------------
      -- SUPER IMPORTANT: <C-Tab> ONLY TRIGGERS SUPERMAVEN IN CMP MENU
      -----------------------------------------------------------------------
      ["<C-X>"] = cmp.mapping(function()
        -- always close existing menu to avoid flicker or race conditions
        if cmp.visible() then
          cmp.close()
        end

        -- Now trigger cmp with ONLY Supermaven
        cmp.complete({
          config = {
            sources = {
              { name = "supermaven" },
            },
          },
        })
      end, { "i", "s" }),

      -- Close popup
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
