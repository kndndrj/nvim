-------------------------
-- Language servers: ----
-------------------------

local M = {}


--
-- Global options
--
local on_attach = function(_, bufnr)
  -- Mappings.
  local map_options = { noremap = true, silent = true, buffer = bufnr }
  -- references
  vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', map_options)
  vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', map_options)
  vim.keymap.set('n', 'gd', '<Cmd>Trouble lsp_definitions<CR>', map_options)
  vim.keymap.set('n', 'gr', '<Cmd>Trouble lsp_references<CR>', map_options)
  vim.keymap.set('n', 'gt', '<Cmd>Trouble lsp_type_definitions<CR>', map_options)
  vim.keymap.set('n', '<leader>g', '<Cmd>TroubleToggle<CR>', map_options)
  -- formatting
  vim.keymap.set('n', '<leader>tt', '<Cmd>lua vim.lsp.buf.format { async = true }<CR>', map_options)
  -- rename
  vim.keymap.set('n', 'gn', '<Cmd>lua vim.lsp.buf.rename()<CR>', map_options)
  -- code action
  vim.keymap.set('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', map_options)
  -- hover
  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', map_options)
  vim.keymap.set('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', map_options)
  -- diagnostic
  vim.keymap.set('n', 'gE', '<Cmd>lua vim.diagnostic.open_float()<CR>', map_options)
  vim.keymap.set('n', 'ge', '<Cmd>Trouble workspace_diagnostics<CR>', map_options)
end

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()


--
-- Configuration function
--
function M.configure()

  -- Floating windows customization
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  -- Icon customization
  vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint', linehl = '', numhl = '' })

  -- Sign priority
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    severity_sort = true
  })

  -- Initialize all language servers
  for server, config in pairs(require 'plugins.configs.lsp.servers') do
    config.capabilities = capabilities
    config.on_attach = on_attach
    require 'lspconfig'[server].setup(config)
  end

  -- Trouble
  require 'trouble'.setup {
    use_diagnostic_signs = true,
    action_keys = {
      close = { "q", "<esc>" }, -- close the list
      cancel = {}, -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r", -- manually refresh
      jump = {}, -- jump to the diagnostic or open / close folds
      open_split = { "<c-x>" }, -- open buffer in new split
      open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
      open_tab = { "<c-t>" }, -- open buffer in new tab
      jump_close = { "o", "<cr>", "<tab>" }, -- jump to the diagnostic and close the list
      toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
      toggle_preview = "P", -- toggle auto_preview
      hover = "K", -- opens a small popup with the full multiline message
      preview = "p", -- preview the diagnostic location
      close_folds = { "zM", "zm" }, -- close all folds
      open_folds = { "zR", "zr" }, -- open all folds
      toggle_fold = { "zA", "za" }, -- toggle fold of current file
      previous = "k", -- previous item
      next = "j" -- next item
    },
  }

end

return M
