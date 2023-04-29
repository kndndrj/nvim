-------------------------
-- List of Sources: -----
-------------------------
return {
  code_actions = {
    gomodifytags = {},
    impl = {},
  },
  completion = {
    -- spell = {},
  },
  diagnostics = {
    eslint = {},
    buf = {
      -- extra_args = { "--config", '{"version":"v1","lint":{"use":["BASIC"]}}' },
    },
    luacheck = {},
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
    mdformat = {
      extra_args = { "--number", "--wrap", "80" },
    },
    yamlfmt = {},
  },
  hover = {
    printenv = {},
  },
}
