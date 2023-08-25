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
    actionlint = {},
    ansiblelint = {},
    buf = {
      -- extra_args = { "--config", '{"version":"v1","lint":{"use":["BASIC"]}}' },
    },
    eslint = {},
    luacheck = {},
    -- mypy = {},
  },
  formatting = {
    black = {},
    beautysh = {},
    buf = {},
    mdformat = {
      extra_args = { "--number", "--wrap", "80" },
    },
    npm_groovy_lint = {},
    sqlfluff = {
      extra_args = { "--dialect", "postgres" },
    },
    stylua = {},
    yamlfmt = {},
  },
  hover = {
    printenv = {},
  },
}
