-------------------------
-- Formatter settings: --
-------------------------

local M = {}

---@param command string[]
---@return string?
local function execute(command)
  if #command < 1 or vim.fn.executable(command[1]) ~= 1 then
    return
  end

  local cmd = table.concat(command, " ")

  local handle = assert(io.popen(cmd))
  local result = handle:read("*all")
  handle:close()

  return string.gsub(result, "\n", "") or ""
end

---@param s string
---@param prefix string
---@return boolean
local function has_prefix(s, prefix)
  return s:find("^" .. prefix) ~= nil
end

--
-- Configuration function
--
function M.configure()
  require("conform").setup {
    formatters_by_ft = {
      zsh = {
        "beautysh",
      },
      bash = {
        "beautysh",
      },
      go = {
        "goswag",
        "goimports-reviser",
        "gofumpt",
      },
      sh = {
        "beautysh",
      },
      proto = {
        "buf",
      },
      java = {
        "google-java-format",
      },
      markdown = {
        "mdformat",
      },
      mojo = {
        "mojo_format",
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
      javascript = {
        "prettier",
      },
      python = {
        "ruff_format",
        "ruff_fix",
        "ruff_organize_imports",
      },
    },
    formatters = {
      yamlfmt = {
        prepend_args = { "-formatter", "retain_line_breaks=true" },
      },
      mdformat = {
        args = { "--wrap", "100", "--number", "-" },
      },
      ruff_format = {
        args = {
          "format",
          "--line-length",
          "120",
          "--force-exclude",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
      },
      goswag = {
        -- custom formatter for swagger docs in go
        command = "swag",
        args = { "fmt", "-d", "$FILENAME" },
        stdin = false,
      },
      ["goimports-reviser"] = {
        prepend_args = function(_, _)
          local mod = execute { "go", "list", "-m" }
          if not mod or mod == "command-line-arguments" then
            return {}
          end

          -- handle known public domains
          if has_prefix(mod, "github.com") or has_prefix(mod, "gitlab.com") or has_prefix(mod, "bitbucket.org") then
            local spl = vim.split(mod, "/")
            if #spl < 2 then
              return {}
            end
            return { "--company-prefixes", spl[1] .. "/" .. spl[2] }
          end

          -- if not known domain, it's probably a local domain
          return { "--company-prefixes", vim.split(mod, "/")[1] }
        end,
      },
    },
  }

  -- autoformat on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
        return
      end
      require("conform").format({ bufnr = args.buf, lsp_fallback = true }, function(err, _)
        if err and err ~= "No formatters found for buffer" then
          vim.notify("formatter error: " .. err, vim.log.levels.ERROR)
        end
      end)
    end,
  })

  -- commands to toggle autoformat
  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })

  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  })
end

return M
