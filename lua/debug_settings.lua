-------------------------
-- Debugger settings: ---
-------------------------

-- enable virtual text
require'nvim-dap-virtual-text'.setup()

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


-------------------------
-- Language settings: ---
-------------------------
-- Python
require'dap-python'.setup('/usr/bin/python')

-- Go
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


local query = require "vim.treesitter.query"

local tests_query = [[
(function_declaration
  name: (identifier) @testname
  parameters: (parameter_list
    . (parameter_declaration
      type: (pointer_type) @type) .)
  (#eq? @type "*testing.T")
  (#match? @testname "^Test.+$")) @parent
]]

local subtests_query = [[
(call_expression
  function: (selector_expression
    operand: (identifier)
    field: (field_identifier) @run)
  arguments: (argument_list
    (interpreted_string_literal) @testname
    (func_literal))
  (#eq? @run "Run")) @parent
]]

local function debug_test(testname)
  local dap = require'dap'
  for _, config in ipairs(dap.configurations.go) do
    if config.name == testname then
      return
    end
  end
  table.insert(dap.configurations.go, {
      type = "go",
      name = testname,
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
      args = {"-test.run", testname},
      dlvToolPath = vim.fn.exepath('dlv'),
  })
  return 1
end

local function get_closest_above_cursor(test_tree)
  local result
  for _, curr in pairs(test_tree) do
    if not result then
      result = curr
    else
      local node_row1, _, _, _ = curr.node:range()
      local result_row1, _, _, _ = result.node:range()
      if node_row1 > result_row1 then
        result = curr
      end
    end
  end
  if result == nil then
    return
  end
  if result.parent then
    return string.format("%s/%s", result.parent, result.name)
  else
    return result.name
  end
end


local function is_parent(dest, source)
  if not (dest and source) then
    return false
  end
  if dest == source then
    return false
  end

  local current = source
  while current ~= nil do
    if current == dest then
      return true
    end

    current = current:parent()
  end

  return false
end

local function get_closest_test()
  local stop_row = vim.api.nvim_win_get_cursor(0)[1]
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  assert(ft == 'go', 'dap-go error: can only debug go files, not '..ft)
  local parser = vim.treesitter.get_parser(0)
  local root = (parser:parse()[1]):root()

  local test_tree = {}

  local test_query = vim.treesitter.parse_query(ft, tests_query)
  assert(test_query, 'dap-go error: could not parse test query')
  for _, match, _ in test_query:iter_matches(root, 0, 0, stop_row) do
    local test_match = {}
    for id, node in pairs(match) do
      local capture = test_query.captures[id]
      if capture == "testname" then
        local name = query.get_node_text(node, 0)
        test_match.name = name
      end
      if capture == "parent" then
        test_match.node = node
      end
    end
    table.insert(test_tree, test_match)
  end

  local subtest_query = vim.treesitter.parse_query(ft, subtests_query)
  assert(subtest_query, 'dap-go error: could not parse test query')
  for _, match, _ in subtest_query:iter_matches(root, 0, 0, stop_row) do
    local test_match = {}
    for id, node in pairs(match) do
      local capture = subtest_query.captures[id]
      if capture == "testname" then
        local name = query.get_node_text(node, 0)
        test_match.name = string.gsub(string.gsub(name, ' ', '_'), '"', '')
      end
      if capture == "parent" then
        test_match.node = node
      end
    end
    table.insert(test_tree, test_match)
  end

  table.sort(test_tree, function(a, b)
    return is_parent(a.node, b.node)
  end)

  for _, parent in ipairs(test_tree) do
    for _, child in ipairs(test_tree) do
      if is_parent(parent.node, child.node) then
        child.parent = parent.name
      end
    end
  end

  return get_closest_above_cursor(test_tree)
end

function Add_test_to_configurations()
  if require'dap'.status() ~= "" then
    return
  end
  local testname = get_closest_test()
  if testname == nil then
    print('No test method found!')
    return
  end
  local state = debug_test(testname)
  if state ~= nil then
    print(string.format("Added '%s' to dap configurations.", testname))
  end
end


-------------------------
-- Other settings: ------
-------------------------
-- Load project-specific configurations aka. from .vscode/launch.json
require'projector.config_utils'.load_dap_configurations()
require'projector.config_utils'.load_project_configurations(vim.fn.getcwd() .. '/.vscode/projector.json')
