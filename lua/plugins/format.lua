-------------------------
-- Formatter settings: --
-------------------------

local M = {}

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
        "goimports-reviser",
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
    },
    formatters = {
      yamlfmt = {
        prepend_args = { "-formatter", "retain_line_breaks=true" },
      },
      mdformat = {
        args = { "--wrap", "100", "--number", "-" },
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
