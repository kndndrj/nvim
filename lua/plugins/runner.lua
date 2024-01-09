-------------------------
-- Runner settings: ---
-------------------------

local M = {}

--
-- Configuration function
--
function M.configure()
  local configs = {
    {
      name = "Go",
      children = {
        {
          name = "Generate",
          command = "go generate",
          args = {
            "${workspaceFolder}/tools.go",
          },
        },
        {
          name = "Run Project",
          command = "go run ${workspaceFolder}/",
          type = "delve",
          request = "launch",
          program = "${workspaceFolder}/",
        },
      },
    },

    {
      name = "Python",
      children = {
        {
          name = "Launch file",
          type = "python",
          request = "launch",
          program = "${file}",
        },
        {
          name = "Launch file with arguments",
          type = "python",
          request = "launch",
          program = "${file}",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
        },
        {
          name = "Attach remote",
          type = "python",
          request = "attach",
          connect = function()
            local host = vim.fn.input("Host [127.0.0.1]: ")
            host = host ~= "" and host or "127.0.0.1"
            local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
            return { host = host, port = port }
          end,
        },
      },
    },

    {
      name = "Shell",
      children = {
        {
          name = "Run current script",
          command = "${fileDirname}/${file}",
        },
      },
    },

    {
      name = "Rust",
      children = {
        {
          name = "Run current project",
          command = "cargo run",
        },
      },
    },
  }

  require("projector").setup {
    loaders = {
      require("projector.loaders").BuiltinLoader:new {
        path = function()
          return vim.fn.getcwd() .. "/.vscode/projector.json"
        end,
        configs = configs,
      },
      require("projector.loaders").DapLoader:new(),
    },
    core = {
      automatic_reload = true,
    },
    outputs = {
      require("projector.outputs").TaskOutputBuilder:new(),
      require("projector.outputs").DapOutputBuilder:new(),
      require("projector_dbee").OutputBuilder:new(),
      require("projector_neotest").OutputBuilder:new { include_debug = true, group = true },
    },
  }

  --
  -- Keymappings
  --
  local map_options = { noremap = true, silent = true }
  -- core
  vim.keymap.set("", "čs", require("projector").continue, map_options)
  vim.keymap.set("n", "čt", require("projector").toggle, map_options)
  vim.keymap.set("n", "čw", require("projector").next, map_options)
  vim.keymap.set("n", "čq", require("projector").previous, map_options)
  vim.keymap.set("n", "čr", require("projector").restart, map_options)
  vim.keymap.set("n", "čk", require("projector").kill, map_options)
  vim.keymap.set("n", "čn", require("dap").step_over, map_options)
  vim.keymap.set("n", "či", require("dap").step_into, map_options)
  vim.keymap.set("n", "čo", require("dap").step_out, map_options)
  vim.keymap.set("n", "čb", require("dap").toggle_breakpoint, map_options)
  vim.keymap.set("n", "čB", function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, map_options)
  vim.keymap.set("n", "čl", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end, map_options)
  -- dap-ui
  vim.keymap.set("v", "če", require("dapui").eval, map_options)
  -- dap-python
  vim.keymap.set("n", "čdn", require("dap-python").test_method, map_options)
  vim.keymap.set("n", "čdf", require("dap-python").test_class, map_options)
  vim.keymap.set("v", "čds", require("dap-python").debug_selection, map_options)
end

return M
