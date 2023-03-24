-------------------------
-- Mason: ---------------
-------------------------

local M = {}

function M.configure()
  -- Initialize meson
  require("mason").setup()

  -- register update cmd
  require("mason-update-all").setup()
end

function M.install(lsps, daps, nullls, extras)
  -- Install language servers
  require("mason-lspconfig").setup {
    ensure_installed = lsps,
  }

  -- Install nullls tools
  require("mason-null-ls").setup {
    ensure_installed = nullls,
  }

  -- Install debug adapters
  require("mason-nvim-dap").setup {
    ensure_installed = daps,
  }

  -- Install extra packages
  require('mason-tool-installer').setup {
    ensure_installed = extras,
  }
end

return M
