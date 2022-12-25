-------------------------
-- LSP options: ---------
-------------------------

local M = {}

-- on attach to buffer
function M.on_attach(_, bufnr)
  -- Mappings.
  local map_options = { noremap = true, silent = true, buffer = bufnr }
  -- references
  vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", map_options)
  vim.keymap.set("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", map_options)
  vim.keymap.set("n", "gd", "<Cmd>Trouble lsp_definitions<CR>", map_options)
  vim.keymap.set("n", "gr", "<Cmd>Trouble lsp_references<CR>", map_options)
  vim.keymap.set("n", "gt", "<Cmd>Trouble lsp_type_definitions<CR>", map_options)
  vim.keymap.set("n", "<leader>g", "<Cmd>TroubleToggle<CR>", map_options)
  -- formatting
  vim.keymap.set("n", "<leader>tt", "<Cmd>lua vim.lsp.buf.format { async = true }<CR>", map_options)
  -- rename
  vim.keymap.set("n", "gn", "<Cmd>lua vim.lsp.buf.rename()<CR>", map_options)
  -- code action
  vim.keymap.set("n", "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>", map_options)
  -- hover
  vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", map_options)
  vim.keymap.set("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", map_options)
  -- diagnostic
  vim.keymap.set("n", "gE", "<Cmd>lua vim.diagnostic.open_float()<CR>", map_options)
  vim.keymap.set("n", "ge", "<Cmd>Trouble workspace_diagnostics<CR>", map_options)
end

-- client capabilities
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
