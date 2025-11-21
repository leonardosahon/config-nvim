return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- High-contrast + polished Kanagawa DRAGON configuration
    require("kanagawa").setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = false, bold = true },
      keywordStyle = { italic = false, bold = true },
      statementStyle = { bold = true },
      typeStyle = { bold = true },

      transparent = false,
      dimInactive = true,
      terminalColors = true,

      colors = {
        theme = {
          dragon = {
            ui = {
              bg_gutter = "none",
              float = {
                bg = "#1F1F28",
                border = "#A6A69C",
              },
            },
          },
        },
      },

      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Make comments readable
          Comment = { fg = theme.syn.comment, bold = true },

          -- Better diagnostic readability
          DiagnosticVirtualTextError = { bg = "none", fg = theme.diag.error },
          DiagnosticVirtualTextWarn = { bg = "none", fg = theme.diag.warn },
          DiagnosticVirtualTextInfo = { bg = "none", fg = theme.diag.info },
          DiagnosticVirtualTextHint = { bg = "none", fg = theme.diag.hint },

          FloatBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.float.bg },

          NormalFloat = { bg = theme.ui.float.bg },

          -- Improve Telescope contrast
          TelescopeNormal = { bg = "#1A1A22" },
          TelescopeBorder = { bg = "#1A1A22", fg = "#1A1A22" },
          TelescopeSelection = { bg = "#2A2A36" },

          -- Cursor line highlight
          CursorLine = { bg = "#2A2A37" },
        }
      end,

      background = {
        dark = "dragon",
        light = "lotus",
      },
    })

    -- Bufferline
    require("bufferline").setup({
      options = {
        separator_style = "slant",
        always_show_bufferline = false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        highlights = {
          fill = { bg = "#1F1F28" },
          background = { bg = "#1F1F28" },
          buffer_selected = { bold = true, italic = false },
        },
      },
    })

    -- Lualine
    require("lualine").setup({
      options = {
        theme = "kanagawa",
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = {
          "branch",
          { "diagnostics", separator = { right = "" } },
        },
        lualine_c = {
          "%=",
          {
            "filename",
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = relative path with truncation, 5 = path segments
            file_status = true, -- displays file status (readonly status, modified status)
          },
        },
        lualine_x = { "selectioncount" },
        lualine_y = { "filetype", "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      },
    })

    vim.cmd("colorscheme kanagawa-dragon")
  end,
}
