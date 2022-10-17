-------------------------
-- List of Sources: -----
-------------------------
return {
  code_actions = {},
  completion = {
    spell = {},
  },
  diagnostics = {
    eslint = {},
    buf = {
      extra_args = { "--config", '{"version":"v1","lint":{"use":["BASIC"]}}' },
    },
    golangci_lint = {},
    actionlint = {},
    ansiblelint = {},
    luacheck = {},
    markdownlint = {},
  },
  formatting = {
    buf = {},
    black = {},
    stylua = {},
    sqlformat = {},
    goimports = {},
  },
  hover = {
    printenv = {},
  },
}
