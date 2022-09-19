-------------------------
-- Snippets: ------------
-------------------------

local M = {}

function M.configure()

	-- Load external snippets
	require 'luasnip.loaders.from_vscode'.lazy_load()


	local map_options = { noremap = true, silent = true }
	vim.api.nvim_set_keymap('i', '<C-d>', '<Cmd>lua require"luasnip".jump(-1)<CR>', map_options)
	vim.api.nvim_set_keymap('s', '<C-d>', '<Cmd>lua require"luasnip".jump(-1)<CR>', map_options)
	vim.api.nvim_set_keymap('i', '<C-f>', '<Cmd>lua require"luasnip".jump(1)<CR>', map_options)
	vim.api.nvim_set_keymap('s', '<C-f>', '<Cmd>lua require"luasnip".jump(1)<CR>', map_options)

end

return M
