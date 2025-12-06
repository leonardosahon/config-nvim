-- Shared function for organizing imports on save
local function setup_organize_imports(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      local range_params = vim.lsp.util.make_range_params(0, client.offset_encoding)
      local params = {
        textDocument = range_params.textDocument,
        range = range_params.range,
        context = {
          only = { "source.organizeImports" },
          diagnostics = {},
        },
      }

      local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
      if not result then
        return
      end

      for _, res in pairs(result) do
        if res.result then
          for _, action in pairs(res.result) do
            -- Resolve the action if it has data
            if action.data then
              local resolved = client.request_sync("codeAction/resolve", action, 1000, bufnr)
              if resolved and resolved.result then
                action = resolved.result
              end
            end

            -- Apply edit first (the actual import organizing)
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
            end

            -- Then execute command if present (notification/cleanup)
            if action.command then
              client.request_sync("workspace/executeCommand", {
                command = action.command.command,
                arguments = action.command.arguments,
              }, 1000, bufnr)
            end
          end
        end
      end
    end,
  })
end

return {
  -- Configure LSP servers with auto-organize imports
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {
          on_attach = setup_organize_imports,
        },
        vtsls = {
          on_attach = setup_organize_imports,
        },
      },
    },
  },
}
