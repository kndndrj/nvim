-------------------------
-- Mason: ---------------
-------------------------

local M = {}

function M.configure(lsps, daps)

  -- Initialize meson
  require("mason").setup()

  -- register update cmd
  require('mason-update-all').setup()

  -- Event notifications
  local registry = require 'mason-registry'
  registry:on("package:install:success", vim.schedule_wrap(function(pkg)
    vim.notify("Mason: Installed " .. pkg.name, vim.log.levels.INFO)
  end))
  registry:on("package:install:failed", vim.schedule_wrap(function(pkg)
    vim.notify("Mason: Error installing " .. pkg.name, vim.log.levels.ERROR)
  end))

  -- Install language servers
  require("mason-lspconfig").setup {
    ensure_installed = lsps,
  }

  -- Install debug adapters
  require("mason-nvim-dap").setup {
    ensure_installed = daps,
  }

end

return M
