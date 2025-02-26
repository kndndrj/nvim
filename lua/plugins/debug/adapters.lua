-------------------------
-- List of Adapters: ----
-------------------------
return {
  cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "OpenDebugAD7",
  },

  delve = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  },

  python = function()
    require("dap-python").setup(nil, { include_configs = false })
  end,

  mojo_lldb = {
    type = "executable",
    command = "mojo-lldb-dap",
  },
}
