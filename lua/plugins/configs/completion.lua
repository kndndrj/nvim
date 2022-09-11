-------------------------
-- Completion: ----------
-------------------------

local M = {}

function M.configure()

  local cmp = require 'cmp'
  cmp.setup {
    snippet = {
      expand = function(args)
        require 'luasnip'.lsp_expand(args.body)
      end,
    },
    preselect = cmp.PreselectMode.None,
    formatting = {
      format = require 'lspkind'.cmp_format(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lua', max_item_count = 10 },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'luasnip' },
      { name = 'buffer', keyword_length = 5 },
    }),
  }

end

return M
