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
  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '', texthl = 'ErrorMsg', linehl = 'Substitute', numhl = 'Substitute' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'WarningMsg', linehl = '', numhl = '' })

  -- enable virtual text
  require 'nvim-dap-virtual-text'.setup()

  -- Set up the UI
  require 'dapui'.setup {
    mappings = {
      expand = { 'l', 'h', '<2-LeftMouse>' },
      open = 'o',
      remove = 'd',
      edit = 'c',
      repl = 'r',
    },
  }

  -- open UI on start
  require 'dap'.listeners.after.event_initialized["dapui_config"] = function()
    require 'dapui'.open()
  end
  require 'dap'.listeners.before.event_terminated["dapui_config"] = function()
    require 'dapui'.close()
  end
  require 'dap'.listeners.before.event_exited["dapui_config"] = function()
    require 'dapui'.close()
  end


  --
  -- Initialize all debug adapters
  --
  for adapter, config in pairs(require'plugins.configs.debug.adapters') do
    if type(config) == 'function' then
      config()
    else
      require 'dap'.adapters[adapter] = config
    end
  end


  --
  -- Configurations
  --
  require 'dap'.configurations.go = {
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}"
    },
    {
      type = "delve",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}"
    },
    -- works with go.mod packages and sub packages
    {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}"
    }
  }

  require 'projector'.configurations.global.tasks.go = {
    {
      name = 'Generate',
      command = 'go generate',
      args = {
        '${workspaceFolder}/tools.go',
      },
    },
  }


  --
  -- Other settings
  --
  -- Load project-specific configurations aka. from .vscode/launch.json
  require 'projector.config_utils'.load_dap_configurations()
  require 'projector.config_utils'.load_project_configurations(vim.fn.getcwd() .. '/.vscode/projector.json')


  --
  -- Keymappings
  --
  local map_options = { noremap = true, silent = true }
  -- core
  vim.api.nvim_set_keymap('n', 'čr', '<Cmd>lua require"projector".continue("all")<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'čt', '<Cmd>lua require"projector".toggle_output()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'čn', '<Cmd>lua require"dap".step_over()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'či', '<Cmd>lua require"dap".step_into()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'čo', '<Cmd>lua require"dap".step_out()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'čb', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'čB', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>'
    , map_options)
  vim.api.nvim_set_keymap('n', 'čl',
    '<Cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'čd', '<Cmd>lua require"dap".run_last()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'čg', '<Cmd>lua Add_test_to_configurations()<CR>', map_options)
  -- dap-ui
  vim.api.nvim_set_keymap('n', 'ču', '<Cmd>lua require"dapui".toggle()<CR>', map_options)
  vim.api.nvim_set_keymap('v', 'če', '<Cmd>lua require("dapui").eval()<CR>', map_options)
  -- dap-python
  vim.api.nvim_set_keymap('n', 'čdn', '<Cmd>lua require("dap-python").test_method()<CR>', map_options)
  vim.api.nvim_set_keymap('n', 'čdf', '<Cmd>lua require("dap-python").test_class()<CR>', map_options)
  vim.api.nvim_set_keymap('v', 'čds', '<ESC><Cmd>lua require("dap-python").debug_selection()<CR>', map_options)

end

return M
