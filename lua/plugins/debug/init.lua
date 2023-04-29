-------------------------
-- Debugger settings: ---
-------------------------

local M = {}

--
-- Configuration function
--
function M.configure()
  --
  -- UI settings
  --
  -- Icon customization
  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "", texthl = "ErrorMsg", linehl = "Substitute", numhl = "Substitute" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "WarningMsg", linehl = "", numhl = "" })

  -- enable virtual text
  require("nvim-dap-virtual-text").setup()
  -- Set up the UI
  require("dapui").setup {
    mappings = {
      expand = { "o", "<2-LeftMouse>" },
      open = "<CR>",
      remove = "d",
      edit = "c",
      repl = "r",
    },
  }

  -- open UI on start
  require("dap").listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open()
  end
  require("dap").listeners.before.event_terminated["dapui_config"] = function()
    require("dapui").close()
  end
  require("dap").listeners.before.event_exited["dapui_config"] = function()
    require("dapui").close()
  end

  --
  -- Initialize all debug adapters
  --
  for adapter, config in pairs(require("plugins.configs.debug.adapters")) do
    if type(config) == "function" then
      config()
    else
      require("dap").adapters[adapter] = config
    end
  end

  -- Mason
  require("mason-nvim-dap").setup {
    ensure_installed = vim.tbl_keys(require("plugins.configs.debug.adapters")),
  }
end

return M
