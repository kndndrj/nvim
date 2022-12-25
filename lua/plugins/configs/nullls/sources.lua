-------------------------
-- List of Sources: -----
-------------------------
return {
  code_actions = {},
  completion = {
    -- spell = {},
  },
  diagnostics = {
    eslint = {},
    buf = {
      -- extra_args = { "--config", '{"version":"v1","lint":{"use":["BASIC"]}}' },
    },
    golangci_lint = {},
    actionlint = {},
    ansiblelint = {},
  },
  formatting = {
    buf = {},
    black = {},
    stylua = {},
    sqlfluff = {
      extra_args = { "--dialect", "postgres" },
    },
    beautysh = {},
    mdformat = {},
    yamlfmt = {},
  },
  hover = {
    printenv = {},
  },
}
