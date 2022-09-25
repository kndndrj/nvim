-------------------------
-- List of Adapters: ----
-------------------------

-- find path separator (ripped form mason.nvim)
local sep = (function()
  ---@diagnostic disable-next-line: undefined-global
  if jit then
    ---@diagnostic disable-next-line: undefined-global
    local os = string.lower(jit.os)
    if os == "linux" or os == "osx" or os == "bsd" then
      return "/"
    else
      return "\\"
    end
  else
    return string.sub(package.config, 1, 1)
  end
end)()


return {
  cppdbg = {
    type = 'executable',
    command = 'OpenDebugAD7',
  },

  delve = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'dlv',
      args = { 'dap', '-l', '127.0.0.1:${port}' },
    },
  },

  python = function()
    require 'dap-python'.setup(table.concat({ vim.fn.stdpath('data'), 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, sep))
  end,
}
