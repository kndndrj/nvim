-------------------------
-- Linter settings: ---
-------------------------

local M = {}

--
-- Configuration function
--
function M.configure()
  require("lint").linters_by_ft = {
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
    python = {
      "mypy",
      "pylint",
    },
    markdown = {
      "vale",
    },
  }

  -- customize
  require("lint").linters.pylint.args = {
    "-f",
    "json",
    "--disable=" .. table.concat({
      "missing-function-docstring",
      "missing-module-docstring",
      "missing-class-docstring",
      "too-few-public-methods",
      "too-many-instance-attributes",
      "too-many-arguments",
      "too-many-branches",
      "broad-exception-caught",
      "fixme",
    }, ","),
    "--max-line-length=120",
  }

  -- run linters on these events
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
    callback = function()
      local lint_status, lin = pcall(require, "lint")
      if lint_status then
        lin.try_lint()
      end
    end,
  })
end

return M
