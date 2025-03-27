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
    go = {
      "golangcilint",
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
      "too-many-return-statements",
      "broad-exception-caught",
      "fixme",
    }, ","),
    "--max-line-length=120",
    "--from-stdin",
    function()
      return vim.api.nvim_buf_get_name(0)
    end,
  }

  require("lint").linters.golangcilint.args = (function()
    local cwd = vim.fn.getcwd()

    ---@type string[]
    local cfgs_prio_list = {
      cwd .. "/.golangci.yml",
      cwd .. "/.golangci.yaml",
      cwd .. "/golangci.yml",
      cwd .. "/.golangci.toml",
      cwd .. "/.golangci.json",
      cwd .. "/.ci/golangci.yml",
      vim.fn.stdpath("config") .. "/assets/golangci.yml",
    }

    for _, path in ipairs(cfgs_prio_list) do
      if vim.fn.filereadable(path) == 1 then
        return {
          "run",
          "--config=" .. path,
          "--output.json.path=stdout",
          "--issues-exit-code=0",
          "--show-stats=false",
          function()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          end,
        }
      end
    end

    -- fallback
    return {
      "run",
      "--output.json.path=stdout",
      "--issues-exit-code=0",
      "--show-stats=false",
      function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
      end,
    }
  end)()

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
