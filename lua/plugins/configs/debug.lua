-------------------------
-- Debugger settings: ---
-------------------------

local M = {}

function M.configure()

  -- enable virtual text
  require 'nvim-dap-virtual-text'.setup()

  -- Set up the UI
  require 'dapui'.setup {
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { 'l', 'h', '<2-LeftMouse>' },
      open = 'o',
      remove = 'd',
      edit = 'c',
      repl = 'r',
    },
  }

  -- Icon customization
  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '', texthl = 'ErrorMsg', linehl = 'Substitute', numhl = 'Substitute' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'WarningMsg', linehl = '', numhl = '' })


  -------------------------
  -- Language settings: ---
  -------------------------
  -- Python
  require 'dap-python'.setup('/usr/bin/python')

  -- C/C++
  require 'dap'.adapters.cppdbg = {
    type = 'executable',
    command = os.getenv('HOME') .. '/Repos/dev/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
  }

  -- Go
  require 'dap'.adapters.go = function(callback, _)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = { nil, stdout },
      args = { "dap", "-l", "127.0.0.1:" .. port },
      detached = true
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print('dlv exited with code', code)
      end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(
      function()
        callback({ type = "server", host = "127.0.0.1", port = port })
      end,
      100)
  end

  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  require 'dap'.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}"
    },
    {
      type = "go",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}"
    },
    -- works with go.mod packages and sub packages
    {
      type = "go",
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

  -- open on start
  -- local dap, dapui = require 'dap', require 'dapui'
  -- dapui.setup {} -- use default
  -- dap.listeners.after.event_initialized['dapui_config'] = function()
  --   dapui.open()
  -- end
  -- dap.listeners.before.event_terminated['dapui_config'] = function()
  --   dapui.close()
  -- end
  -- dap.listeners.before.event_exited['dapui_config'] = function()
  --   dapui.close()
  -- end


  -------------------------
  -- Other settings: ------
  -------------------------
  -- Load project-specific configurations aka. from .vscode/launch.json
  require 'projector.config_utils'.load_dap_configurations()
  require 'projector.config_utils'.load_project_configurations(vim.fn.getcwd() .. '/.vscode/projector.json')



  -- Keymappings
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
