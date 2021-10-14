-------------------------
-- LSP settings: --------
-------------------------

-- Icons
require'lspkind'.init{}

-- Compe settings for autocompletion
require'compe'.setup{
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    luasnip = true,
  };
}
-- hide 'Pattern not found'
vim.opt.shortmess = vim.opt.shortmess + 'c'
-------------------------
-- LSP Saga: ------------
-------------------------
require'lspsaga'.init_lsp_saga{
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
  scroll_up = '<C-b>',
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
border_style = "round",
rename_prompt_prefix = '➤',
}

-------------------------
-- Snippets: ------------
-------------------------
local luasnip = require'luasnip'

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip and luasnip.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip and luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

-- Load external snippets (aka. from rafamadriz/friendly-snippets)
require('luasnip/loaders/from_vscode').load()

-------------------------
-- Autopairs: -----------
-------------------------
require'nvim-autopairs'.setup{
  check_ts = true
}

require'nvim-autopairs.completion.compe'.setup{
  map_cr = true,
  map_complete = true,
  auto_select = false,
}

-------------------------
-- Language servers: ----
-------------------------

-- List of language servers
local servers = {
  'clangd',
  'gopls',
  'rust_analyzer',
  'html',
  'jsonls',
  'denols',
  'cssls',
  'bashls',
  'texlab',
  'pylsp',
  'sumneko_lua',
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
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

-- Special case
require'lspconfig'.sumneko_lua.setup{
  cmd = {'lua-language-server'},
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim', 'use'},
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
