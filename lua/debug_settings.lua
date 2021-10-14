-------------------------
-- Debugger settings: ---
-------------------------
require'dap'

-- enable virtual text
vim.g.dap_virtual_text = true

-- Set up the UI
require'dapui'.setup {
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { 'l',  'h', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'c',
    repl = 'r',
  },
}

-- Icon customization
vim.fn.sign_define('DapBreakpoint',          {text='', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint',            {text='', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapStopped',             {text='', texthl='ErrorMsg', linehl='Substitute', numhl='Substitute'})
vim.fn.sign_define('DapBreakpointRejected',  {text='', texthl='WarningMsg', linehl='', numhl=''})

-- Language specific configs
-- python
require'dap-python'.setup('/usr/bin/python')
-- go
require'dap'.adapters.go = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/Repos/dev/vscode-go/dist/debugAdapter.js'},
}
require'dap'.configurations.go = {
  {
    type = 'go',
    name = 'Debug Current File',
    request = 'launch',
    showLog = false,
    program = '${file}',
    dlvToolPath = vim.fn.exepath('dlv'),
  },
  {
    type = 'go',
    name = 'Debug Test',
    request = 'launch',
    mode = 'test',
    showLog = false,
    program = '${file}',
    dlvToolPath = vim.fn.exepath('dlv'),
  },
}

-- Load project-specific configurations from .vscode/launch.json
require('dap.ext.vscode').load_launchjs()
