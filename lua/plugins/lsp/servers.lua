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
            maxLineLength = 120,
          },
        },
      },
    },
  },

  ruby_ls = {
    -- TODO: remove when nvim 0.10 releases
    on_attach = (function()
      -- textDocument/diagnostic support until 0.10.0 is released
      local _timers = {}
      return function(client, buffer)
        if require("vim.lsp.diagnostic")._enable then
          return
        end

        local diagnostic_handler = function()
          local params = vim.lsp.util.make_text_document_params(buffer)
          client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
            if err then
              local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
              vim.lsp.log.error(err_msg)
            end
            local diagnostic_items = {}
            if result then
              diagnostic_items = result.items
            end
            vim.lsp.diagnostic.on_publish_diagnostics(
              nil,
              vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
              { client_id = client.id }
            )
          end)
        end

        diagnostic_handler() -- to request diagnostics on buffer when first attaching

        vim.api.nvim_buf_attach(buffer, false, {
          on_lines = function()
            if _timers[buffer] then
              vim.fn.timer_stop(_timers[buffer])
            end
            _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
          end,
          on_detach = function()
            if _timers[buffer] then
              vim.fn.timer_stop(_timers[buffer])
            end
          end,
        })
      end
    end)(),
  },

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
