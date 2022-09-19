-------------------------
-- LSP settings: --------
-------------------------

-- Icon customization
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint', linehl = '', numhl = '' })

-- Sign priority
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  severity_sort = true
}
)


-------------------------
-- Language servers: ----
-------------------------

local M = {}

function M.configure()

  -- List of language servers with default config
  local servers = {
    --'clangd',
    'gopls',
    'rust_analyzer',
    --'denols',
    'bashls',
    'texlab',
    --'pylsp',
    'yamlls',
  }

  --Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require 'cmp_nvim_lsp'.update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }

  -- Setup all language servers
  for _, server in pairs(servers) do
    require 'lspconfig'[server].setup {
      capabilities = capabilities
    }
  end

  -- Special cases
  require 'lspconfig'.sumneko_lua.setup {
    capabilities = capabilities,
    cmd = { 'lua-language-server' },
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
      },
    },
  }
  require 'lspconfig'.ccls.setup {
    capabilities = capabilities,
    init_options = {
      compilationDatabaseDirectory = 'build',
    },
  }
  require 'lspconfig'.pylsp.setup {
    capabilities = capabilities,
    settings = {
      pylsp = {
        configurationSources = { 'pycodestyle', 'flake8' },
      },
    },
  }
  require 'lspconfig'.jsonls.setup {
    capabilities = capabilities,
    cmd = { 'vscode-json-languageserver', '--stdio' },
  }
  require 'lspconfig'.html.setup {
    capabilities = capabilities,
    cmd = { 'vscode-html-languageserver', '--stdio' },
  }
  require 'lspconfig'.cssls.setup {
    capabilities = capabilities,
    cmd = { 'vscode-css-languageserver', '--stdio' },
  }
  require 'lspconfig'.sqlls.setup {
    capabilities = capabilities,
    cmd = { 'sql-language-server', 'up', '--method', 'stdio' };
  }
  require 'lspconfig'.tsserver.setup {
    capabilities = capabilities,
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
  }


  -- Trouble
  require 'trouble'.setup()


  local map_options = { noremap = true, silent = true }

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

return M
