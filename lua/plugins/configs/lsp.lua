-------------------------
-- Language servers: ----
-------------------------

local M = {}


--
-- List of language servers
--
M.servers = {
  gopls = {},

  rust_analyzer = {},

  bashls = {},

  texlab = {},

  yamlls = {},

  pylsp = {
    settings = {
      pylsp = {
        configurationSources = { 'pycodestyle', 'flake8' },
        plugins = {
          pycodestyle = {
            maxLineLength = 100,
          },
        },
      },
    },
  },

  ccls = {
    init_options = {
      compilationDatabaseDirectory = 'build',
    },
  },
  sumneko_lua = {
    cmd = { 'lua-language-server' },
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
      },
    },
  },

  jsonls = {
    cmd = { 'vscode-json-languageserver', '--stdio' },
  },

  html = {
    cmd = { 'vscode-html-languageserver', '--stdio' },
  },

  cssls = {
    cmd = { 'vscode-css-languageserver', '--stdio' },
  },

  sqlls = {
    cmd = { 'sql-language-server', 'up', '--method', 'stdio' };
  },

  tsserver = {
    settings = {
      codeActionsOnSave = {
        source = {
          organizeImports = true,
        },
      },
      javascript = {
        format = {
          semicolons = 'insert',
        },
      }
    },
  },
}


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
  vim.keymap.set('n', '<leader>tt', '<Cmd>lua vim.lsp.buf.formatting()<CR>', map_options)
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp'.update_capabilities(capabilities)


--
-- Configuration function
--
function M.configure()

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
  for server, config in pairs(M.servers) do
    config.capabilities = capabilities
    config.on_attach = on_attach
    require 'lspconfig'[server].setup(config)
  end

  -- Trouble
  require 'trouble'.setup {
    use_diagnostic_signs = true,
  }

end

return M
