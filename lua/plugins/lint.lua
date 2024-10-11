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
      "too-many-locals",
      "too-many-branches",
      "too-many-statements",
      "broad-exception-caught",
      "fixme",
    }, ","),
    "--max-line-length=120",
    "--from-stdin",
    function()
      return vim.api.nvim_buf_get_name(0)
    end,
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
