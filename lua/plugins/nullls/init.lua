-------------------------
-- Null Ls settings: ---
-------------------------

local M = {}

--
-- Configuration function
--
function M.configure()
  local null_ls = require("null-ls")

  -- Generate sources map from sources configs
  local sources_configs = require("plugins.nullls.sources")
  local sources = {}
  for type, configs in pairs(sources_configs) do
    for source, config in pairs(configs) do
      table.insert(sources, null_ls.builtins[type][source].with(config))
    end
  end

  -- call the setup function
  null_ls.setup {
    on_attach = require("plugins.lsp.options").on_attach,
    sources = sources,
  }

  -- Mason
  local to_install = {}
  for _, srcs in pairs(require("plugins.nullls.sources")) do
    for src, _ in pairs(srcs) do
      table.insert(to_install, src)
    end
  end
  require("mason-null-ls").setup {
    ensure_installed = to_install,
  }
end

return M
