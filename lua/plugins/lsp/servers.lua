-------------------------
-- List of Servers: -----
-------------------------

return {
  ansiblels = {},

  bashls = {},

  buf_ls = {},

  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  },

  cssls = {},

  dockerls = {},

  eslint = {},

  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        analyses = {
          composites = false,
        },
      },
    },
  },

  html = {},

  jdtls = {},

  jsonls = {},

  lemminx = {},

  mojo = {},

  ols = {},

  pylsp = {
    settings = {
      pylsp = {
        configurationSources = { "pycodestyle", "flake8" },
        plugins = {
          pycodestyle = {
            maxLineLength = 120,
          },
          rope_autoimport = {
            enabled = true,
          },
        },
      },
    },
  },

  ruff = {},

  rust_analyzer = {},

  sqlls = {
    cmd = { "sql-language-server", "up", "--method", "stdio" },
  },

  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        telemetry = {
          enable = false,
        },
        format = {
          enable = false,
        },
        diagnostics = {
          disable = {
            "missing-fields",
          },
        },
        workspace = {
          checkThirdParty = false,
          -- add all nvim runtime paths to workspace
          -- snippet taken from neodev.nvim
          library = (function()
            local ret = {}

            local function add(lib)
              for _, p in ipairs(vim.fn.expand(lib .. "/lua", false, true)) do
                p = vim.loop.fs_realpath(p)
                if p then
                  table.insert(ret, vim.fn.fnamemodify(p, ":h"))
                end
              end
            end

            add("$VIMRUNTIME")

            ---@type table<string, boolean>
            for _, site in pairs(vim.split(vim.o.packpath, ",")) do
              add(site .. "/pack/*/opt/*")
              add(site .. "/pack/*/start/*")
            end

            -- add support for lazy.nvim
            if package.loaded["lazy"] then
              for _, plugin in ipairs(require("lazy").plugins()) do
                add(plugin.dir)
              end
            end

            return ret
          end)(),
        },
      },
    },
  },

  taplo = {},

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

  ts_ls = {
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

  zls = {},
}
