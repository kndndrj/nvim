-------------------------
-- Linter settings: ---
-------------------------

local M = {}

--
-- Configuration function
--
function M.configure()
  local linters = {
    zsh = {
      "shellcheck",
    },
    bash = {
      "shellcheck",
    },
    sh = {
      "shellcheck",
    },
    javascript = {
      "eslint_d",
    },
    typescript = {
      "eslint_d",
    },
    javascriptreact = {
      "eslint_d",
    },
    typescriptreact = {
      "eslint_d",
    },
    yaml = {
      "actionlint",
    },
    proto = {
      "buf_lint",
    },
    lua = {
      "luacheck",
    },
    -- python = {
    --   "mypy",
    -- },
    markdown = {
      "vale",
    },
  }

  require("lint").linters_by_ft = linters

  -- run linters on these events
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
    callback = function()
      local lint_status, lin = pcall(require, "lint")
      if lint_status then
        lin.try_lint()
      end
    end,
  })

  -- auto install the linters
  require("mason-nvim-lint").setup()
end

return M
