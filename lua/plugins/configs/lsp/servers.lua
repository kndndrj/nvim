-------------------------
-- List of Servers: -----
-------------------------
return {
  bashls = {},

  bufls = {},

  clangd = {
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' }
  },

  cssls = {},

  dockerls = {},

  gopls = {},

  html = {},

  jsonls = {},

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

  rust_analyzer = {},

  sqlls = {
    cmd = { 'sql-language-server', 'up', '--method', 'stdio' };
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

  texlab = {},

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

  yamlls = {},
}
