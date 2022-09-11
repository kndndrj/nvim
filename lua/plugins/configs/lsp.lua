-------------------------
-- LSP settings: --------
-------------------------

-- Icon customization
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint', linehl = '', numhl = '' })

-- Sign priority
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
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


  local map_options = { noremap = true, silent = true }

  -- references
  vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', map_options)
  -- formatting
  vim.api.nvim_set_keymap('n', '<leader>tt', '<Cmd>lua vim.lsp.buf.formatting()<CR>', map_options)
  -- rename
  vim.api.nvim_set_keymap('n', 'gn', '<Cmd>lua vim.lsp.buf.rename()<CR>', map_options)
  -- code action
  vim.api.nvim_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', map_options)
  -- hover
  vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', map_options)
  -- diagnostic
  vim.api.nvim_set_keymap('n', 'de', '<Cmd>lua vim.diagnostic.open_float()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'dN', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'dn', '<Cmd>lua vim.diagnostic.goto_next()<CR>', map_options)

end

return M
