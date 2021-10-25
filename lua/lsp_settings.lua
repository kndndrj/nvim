-------------------------
-- LSP settings: --------
-------------------------

-- nvim-cmp setup
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  formatting = {
    format = require'lspkind'.cmp_format(),
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-l>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    --['<Tab>'] = cmp.mapping(function(fallback)
    --  if cmp.visible() then
    --    cmp.select_next_item()
    --  elseif luasnip.jumpable(1) then
    --    luasnip.jump(1)
    --  elseif has_words_before() then
    --    cmp.complete()
    --  else
    --    fallback()
    --  end
    --end, { 'i', 's' }),
    --['<S-Tab>'] = cmp.mapping(function(fallback)
    --  if cmp.visible() then
    --    cmp.select_prev_item()
    --  elseif luasnip.jumpable(-1) then
    --    luasnip.jump(-1)
    --  else
    --    fallback()
    --  end
    --end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lua', max_item_count = 10},
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 5 },
  },
}

-- Load external snippets (aka. from rafamadriz/friendly-snippets)
require'luasnip.loaders.from_vscode'.load()

-------------------------
-- Autopairs: -----------
-------------------------
require'nvim-autopairs'.setup {
  check_ts = true
}

require'nvim-autopairs.completion.cmp'.setup {
  map_cr = true,
  map_complete = true,
  auto_select = false,
  insert = false,
  map_char = {
    all = '(',
    tex = '{'
  }
}

-------------------------
-- LSP Saga: ------------
-------------------------
require'lspsaga'.init_lsp_saga {
use_saga_diagnostic_sign = true,
error_sign = '',
warn_sign = '',
hint_sign = '',
infor_sign = '',
dianostic_header_icon = '   ',
code_action_icon = ' ',
code_action_prompt = {
  enable = true,
  sign = false,
  sign_priority = 20,
  virtual_text = false,
},
finder_definition_icon = '  ',
finder_reference_icon = '  ',
max_preview_lines = 10,
finder_action_keys = {
  open = 'o',
  vsplit = 'v',
  split = 's',
  quit = '<ESC>',
  scroll_down = '<C-f>',
  scroll_up = '<C-d>',
},
code_action_keys = {
  quit = '<ESC>',
  exec = '<CR>',
},
rename_action_keys = {
  quit = '<ESC>',
  exec = '<CR>',
},
definition_preview_icon = '  ',
border_style = 'round',
rename_prompt_prefix = '➤',
}

-------------------------
-- Language servers: ----
-------------------------

-- List of language servers
local servers = {
  'clangd',
  'gopls',
  'rust_analyzer',
  'denols',
  'bashls',
  'texlab',
  'pylsp',
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Setup all language servers
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{
    capabilities = capabilities
  }
end

-- Special cases
require'lspconfig'.sumneko_lua.setup{
  capabilities = capabilities,
  cmd = {'lua-language-server'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim', 'use'},
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
require'lspconfig'.jsonls.setup{
  capabilities = capabilities,
  cmd = {'vscode-json-languageserver', '--stdio'},
}
require'lspconfig'.html.setup{
  capabilities = capabilities,
  cmd = {'vscode-html-languageserver', '--stdio'},
}
require'lspconfig'.cssls.setup{
  capabilities = capabilities,
  cmd = {'vscode-css-languageserver', '--stdio'},
}
require'lspconfig'.sqlls.setup{
  capabilities = capabilities,
  cmd = {'sql-language-server', 'up', '--method', 'stdio'};
}
