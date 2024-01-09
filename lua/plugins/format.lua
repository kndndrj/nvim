-------------------------
-- Formatter settings: --
-------------------------

local M = {}

--
-- Configuration function
--
function M.configure()
  local formatters = {
    zsh = {
      "beautysh",
    },
    bash = {
      "beautysh",
    },
    sh = {
      "beautysh",
    },
    proto = {
      "buf",
    },
    markdown = {
      "mdformat",
    },
    sql = {
      "sqlfluff",
    },
    lua = {
      "stylua",
    },
    yaml = {
      "yamlfmt",
    },
    latex = {
      "latexindent",
    },
  }

  require("conform").setup {
    formatters_by_ft = formatters,
    formatters = {
      yamlfmt = {
        prepend_args = { "-formatter", "retain_line_breaks=true" },
      },
    },
  }

  -- run linters on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format { bufnr = args.buf, lsp_fallback = true }
    end,
  })

  -- keymap for manual formatting
  local map_options = { noremap = true, silent = true }
  vim.keymap.set("n", "<leader>tt", function()
    require("conform").format { async = true, lsp_fallback = true }
  end, map_options)

  -- Install extra packages
  local to_install = {}
  for _, tbl in pairs(formatters) do
    for _, f in ipairs(tbl) do
      table.insert(to_install, f)
    end
  end

  require("mason-tool-installer").setup {
    ensure_installed = to_install,
  }
end

return M
