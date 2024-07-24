-------------------------
-- Language servers: ----
-------------------------

local M = {}

--
-- Configuration function
--
function M.configure()
  -- Floating windows customization
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  -- Icon customization
  vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })

  -- Sign priority
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    severity_sort = true,
  })

  local options = require("plugins.lsp.options")

  -- Initialize all language servers
  for server, config in pairs(require("plugins.lsp.servers")) do
    config.capabilities = options.capabilities
    config.on_attach = options.on_attach
    require("lspconfig")[server].setup(config)
  end

  -- Glance
  local actions = require("glance").actions
  require("glance").setup {
    detached = true,
    height = 25,
    border = {
      enable = true,
      top_char = "―",
      bottom_char = "―",
    },
    list = {
      position = "left",
      width = 0.33,
    },
    indent_lines = {
      enable = true,
      icon = " ",
    },
    mappings = {
      list = {
        ["<c-s>l"] = actions.enter_win("preview"),
        ["<c-s>h"] = actions.enter_win("preview"),
      },
      preview = {
        ["<c-s>l"] = actions.enter_win("list"),
        ["<c-s>h"] = actions.enter_win("list"),
        ["q"] = actions.close,
      },
    },
    folds = {
      fold_closed = "",
      fold_open = "",
      folded = true,
    },
    hooks = {
      -- Don't open glance when there is only one result and it is located in the current buffer, open otherwise
      before_open = function(results, open, jump, _method)
        local uri = vim.uri_from_bufnr(0)
        if #results == 1 then
          local target_uri = results[1].uri or results[1].targetUri

          if target_uri == uri then
            jump(results[1])
          else
            open(results)
          end
        else
          open(results)
        end
      end,
    },
  }
end

return M
