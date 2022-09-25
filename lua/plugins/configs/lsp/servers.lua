-------------------------
-- List of Servers: -----
-------------------------
return {

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

  clangd = {},

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

  jsonls = {},

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
