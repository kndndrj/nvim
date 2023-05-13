-------------------------
-- List of Servers: -----
-------------------------

---@param f fun():any
---@return any
local function exc(f)
  return f()
end

return {
  bashls = {},

  bufls = {},

  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  },

  cssls = {},

  dockerls = {},

  gopls = {},

  golangci_lint_ls = {
    init_options = {
      command = exc(function()
        ---@type string[]
        local cfgs_prio_list = {
          vim.fn.getcwd() .. "/.ci/golangci.yml",
          vim.fn.getcwd() .. "/golangci.yml",
          vim.fn.stdpath("config") .. "/assets/golangci.yml",
        }

        for _, path in ipairs(cfgs_prio_list) do
          if vim.fn.filereadable(path) == 1 then
            return { "golangci-lint", "run", "--config", path, "--out-format", "json" }
          end
        end

        -- fallback
        return { "golangci-lint", "run", "--out-format", "json" }
      end),
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