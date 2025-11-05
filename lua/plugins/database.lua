return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod",
    "tpope/vim-dotenv",
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "pgsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },

  keys = {
    { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
    { "<leader>dq", "<cmd>DBUIFindBuffer<cr>", desc = "Find Database Buffer" },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    -- vim.g.db_ui_force_echo_notifications = 1
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_winwidth = 30

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql", "pgsql" },
      callback = function()
        local cmp = require("cmp")
        local sources = cmp.get_config().sources or {}

        -- Add dadbod completion as first source for SQL files
        table.insert(sources, 1, { name = "vim-dadbod-completion" })

        cmp.setup.buffer({
          sources = sources,
        })
        -- Remove the default :w execution mapping
        -- vim.api.nvim_buf_del_keymap(0, "n", "<leader>W") -- Just in case
        vim.api.nvim_buf_del_keymap(0, "n", "<Plug>(DBUI_ExecuteQuery)")

        -- Remap :r to execute the query
        vim.api.nvim_buf_set_keymap(0, "n", ":r", ":DBUIExecuteQuery<CR>", { noremap = true, silent = true })
      end,
    })
  end,
}
