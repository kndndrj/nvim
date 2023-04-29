-------------------------
-- LSP options: ---------
-------------------------

local M = {}

-- on attach to buffer
function M.on_attach(_, bufnr)
  -- Mappings.
  local map_options = { noremap = true, silent = true, buffer = bufnr }

  -- references
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, map_options)
  vim.keymap.set("n", "gd", "<CMD>Glance definitions<CR>")
  vim.keymap.set("n", "gi", "<CMD>Glance implementations<CR>")
  vim.keymap.set("n", "gr", "<CMD>Glance references<CR>")
  vim.keymap.set("n", "gt", "<CMD>Glance type_definitions<CR>")

  -- formatting
  vim.keymap.set("n", "<leader>tt", function()
    vim.lsp.buf.format { async = true }
  end, map_options)
  -- rename
  vim.keymap.set("n", "gn", vim.lsp.buf.rename, map_options)
  -- code action
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, map_options)
  -- hover
  vim.keymap.set("n", "K", vim.lsp.buf.hover, map_options)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, map_options)
  -- diagnostic
  vim.keymap.set("n", "gE", vim.diagnostic.open_float, map_options)
  vim.keymap.set("n", "geN", vim.diagnostic.goto_prev, map_options)
  vim.keymap.set("n", "gen", vim.diagnostic.goto_next, map_options)
end

-- client capabilities
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M