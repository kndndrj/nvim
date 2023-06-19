-------------------------
-- List of Servers: -----
-------------------------

return {
  bashls = {},

  bufls = {},

  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  },

  cssls = {},

  dockerls = {},

  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  },

  golangci_lint_ls = {
    init_options = {
      command = (function()
        local cwd = vim.fn.getcwd()

        ---@type string[]
        local cfgs_prio_list = {
          cwd .. ".golangci.yml",
          cwd .. ".golangci.yaml",
          cwd .. ".golangci.toml",
          cwd .. ".golangci.json",
          cwd .. "/.ci/golangci.yml",
          cwd .. "/golangci.yml",
          vim.fn.stdpath("config") .. "/assets/golangci.yml",
        }

        for _, path in ipairs(cfgs_prio_list) do
          if vim.fn.filereadable(path) == 1 then
            return { "golangci-lint", "run", "--config", path, "--out-format", "json" }
          end
        end

        -- fallback
        return { "golangci-lint", "run", "--out-format", "json" }
      end)(),
    },
  },

  html = {},

  jsonls = {},

  pylsp = {
    settings = {
      pylsp = {
        configurationSources = { "pycodestyle", "flake8" },
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
    cmd = { "sql-language-server", "up", "--method", "stdio" },
  },

  lua_ls = {
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
        format = {
          enable = false,
        },
      },
    },
  },

  texlab = {
    settings = {
      texlab = {
        bibtexFormatter = "texlab",
        build = {
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          executable = "latexmk",
          forwardSearchAfter = false,
          onSave = false,
        },
        formatterLineLength = 100,
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = true,
        },
      },
    },
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
          semicolons = "insert",
        },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },
}
