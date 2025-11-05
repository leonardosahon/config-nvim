return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    local ok_luasnip, luasnip = pcall(require, "luasnip")

    -- Optional: disable ghost text if you don't like it
    opts.experimental = opts.experimental or {}
    opts.experimental.ghost_text = false

    opts.snippet = {
      expand = function(args)
        if ok_luasnip then
          luasnip.lsp_expand(args.body)
        end
      end,
    }

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      -- Maintain enter key's normal behaviour
      ["<CR>"] = cmp.mapping(function(fallback)
        fallback()
      end, { "i" }),

      -- ✅ Enter: insert plain text (no snippet placeholders)
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if entry then
            local insertText = entry:get_insert_text()
            if insertText:match("%$%{") then
              insertText = insertText:gsub("%$%b{}", "")
            end
            vim.api.nvim_feedkeys(insertText, "i", true)
            cmp.close()
          else
            fallback()
          end
        else
          fallback()
        end
      end, { "i", "s" }),

      -- ✅ Esc: close popup first, second Esc exits insert mode
      ["<Esc>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.close()
        else
          fallback()
        end
      end, { "i", "s" }),
    })
  end,
}
