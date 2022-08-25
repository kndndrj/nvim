-------------------------
-- Debugger settings: ---
-------------------------

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


-------------------------
-- Other settings: ------
-------------------------
-- Load project-specific configurations aka. from .vscode/launch.json
require 'projector.config_utils'.load_dap_configurations()
require 'projector.config_utils'.load_project_configurations(vim.fn.getcwd() .. '/.vscode/projector.json')
