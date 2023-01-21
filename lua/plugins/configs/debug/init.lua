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

  --
  -- Configurations
  --
  local configs = {
    -- Go
    {
      name = "Generate",
      group = "go",
      command = "go generate",
      args = {
        "${workspaceFolder}/tools.go",
      },
      presentation = "menuhidden",
    },
    {
      name = "Debug",
      group = "go",
      type = "delve",
      request = "launch",
      program = "${file}",
      presentation = "menuhidden",
    },
    {
      name = "Current Directory Project",
      command = "go run ${workspaceFolder}/",
      group = "go",
      type = "delve",
      request = "launch",
      program = "${workspaceFolder}/",
      presentation = "menuhidden",
    },
    -- configuration for debugging test files
    {
      name = "Debug test",
      group = "go",
      type = "delve",
      request = "launch",
      mode = "test",
      program = "${file}",
      presentation = "menuhidden",
    },
    -- works with go.mod packages and sub packages
    {
      name = "Debug test (go.mod)",
      group = "go",
      type = "delve",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
      presentation = "menuhidden",
    },

    -- Python
    {
      name = "Launch file",
      group = "python",
      type = "python",
      request = "launch",
      program = "${file}",
      presentation = "menuhidden",
    },
    {
      name = "Launch file with arguments",
      group = "python",
      type = "python",
      request = "launch",
      program = "${file}",
      args = function()
        local args_string = vim.fn.input("Arguments: ")
        return vim.split(args_string, " +")
      end,
      presentation = "menuhidden",
    },
    {
      name = "Attach remote",
      group = "python",
      type = "python",
      request = "attach",
      connect = function()
        local host = vim.fn.input("Host [127.0.0.1]: ")
        host = host ~= "" and host or "127.0.0.1"
        local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
        return { host = host, port = port }
      end,
      presentation = "menuhidden",
    },
    {
      name = "Run tests in file",
      group = "python",
      command = "pytest",
      args = { "${file}" },
      presentation = "menuhidden",
    },

    -- Shell
    {
      name = "Run current script",
      group = "sh",
      command = "${fileDirname}/${file}",
      presentation = "menuhidden",
    },

    -- Rust
    {
      name = "Run current project",
      group = "rust",
      command = "cargo run",
      presentation = "menuhidden",
    },
  }

  --
  -- Projector setup
  --
  -- Load project-specific configurations aka. from .vscode/launch.json
  require("projector").setup {
    loaders = {
      {
        module = "tasksjson",
        options = vim.fn.getcwd() .. "/.vscode/tasks.json",
      },
      {
        module = "launchjson",
        options = vim.fn.getcwd() .. "/.vscode/launch.json",
      },
      {
        module = "builtin",
        options = {
          path = vim.fn.getcwd() .. "/.vscode/projector.json",
          configs = configs,
        },
      },
    },
    display_format = function(_, scope, group, modes, name)
      return scope .. "  " .. group .. "  " .. modes .. "  " .. name
    end,
    automatic_reload = true,
  }

  --
  -- Keymappings
  --
  local map_options = { noremap = true, silent = true }
  -- core
  vim.api.nvim_set_keymap("n", "čs", '<Cmd>lua require"projector".continue()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "čt", '<Cmd>lua require"projector".toggle()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "čw", '<Cmd>lua require"projector".next()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "čq", '<Cmd>lua require"projector".previous()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "čr", '<Cmd>lua require"projector".restart()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "čk", '<Cmd>lua require"projector".kill()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "čn", '<Cmd>lua require"dap".step_over()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "či", '<Cmd>lua require"dap".step_into()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "čo", '<Cmd>lua require"dap".step_out()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "čb", '<Cmd>lua require"dap".toggle_breakpoint()<CR>', map_options)
  vim.api.nvim_set_keymap(
    "n",
    "čB",
    '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    map_options
  )
  vim.api.nvim_set_keymap(
    "n",
    "čl",
    '<Cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    map_options
  )
  vim.api.nvim_set_keymap("n", "čg", "<Cmd>lua Add_test_to_configurations()<CR>", map_options)
  -- dap-ui
  vim.api.nvim_set_keymap("v", "če", '<Cmd>lua require("dapui").eval()<CR>', map_options)
  -- dap-python
  vim.api.nvim_set_keymap("n", "čdn", '<Cmd>lua require("dap-python").test_method()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "čdf", '<Cmd>lua require("dap-python").test_class()<CR>', map_options)
  vim.api.nvim_set_keymap("v", "čds", '<ESC><Cmd>lua require("dap-python").debug_selection()<CR>', map_options)
end

return M
