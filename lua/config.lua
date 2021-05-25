require 'plugins'
require 'telescope_settings'
require 'indentline_settings'
require 'lsp_settings'
require 'vimtex_settings'
require 'treesitter_settings'

-- Macros
local cmd = vim.cmd
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.o
local wo = vim.wo
local bo = vim.bo

-----------------------
-- Basic Config: ------
-----------------------

o.hidden = true

-- Split defaults
o.splitbelow = true
o.splitright = true

-- Enable colors
o.termguicolors = true

-- Display relative line numbers
wo.number = true
o.numberwidth = 2

-- Enable mouse
o.mouse = 'a'

-- Rows below the statusline
o.cmdheight = 1
-- Cursorline
wo.cursorline = true
-- Don't display mode
o.showmode = false

-- Shorter updatetime
o.updatetime = 250

-- Tab (key) settings
bo.tabstop = 8
bo.expandtab = true
bo.shiftwidth = 4
bo.softtabstop = 0
o.smarttab = true

-- Highlight column 100 to easily maintain line length
wo.colorcolumn = '80'

-- Autocomplete menu
o.completeopt = 'menuone,noselect'

-- any combination of 'wq' works
cmd ':command! WQ wq'
cmd ':command! Wq wq'
cmd ':command! Wqa wqa'
cmd ':command! W w'
cmd ':command! Q q'

-- Autocommands
cmd 'autocmd BufWinEnter * :DetectIndent'
cmd 'autocmd BufWritePost plugins.lua PackerCompile'
cmd 'autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}'
cmd 'autocmd BufNewFile,BufRead *.groff set filetype=groff'
cmd 'autocmd BufWinEnter,WinEnter term://* startinsert'

-- Git signs setup
require'gitsigns'.setup()

-- Smooth scrolling
require('neoscroll').setup({
  mappings = {'<C-u>', '<C-d>', '<C-b>',
              '<C-f>', 'zt', 'zz', 'zb'},
})

-----------------------
-- Key Bindings: ------
-----------------------

-- Binding options
map_options = { noremap=true, silent=true }

-- Map leader to space
g.mapleader = ' '

-- <Leader>Escape key functions
map('n', '<leader><esc>', ':cclose<CR> :nohlsearch<CR>', map_options)

-- Cycle quickfix lists
map('n', '<leader>j', ':cnext<CR>', map_options)
map('n', '<leader>k', ':cprev<CR>', map_options)
map('n', '<leader>o', ':copen<CR>', map_options)

-- Use alt+hjkl to move between windows in any mode
map('t', '<A-h>', '<C-\\><C-N><C-w>h', map_options)
map('t', '<A-j>', '<C-\\><C-N><C-w>j', map_options)
map('t', '<A-k>', '<C-\\><C-N><C-w>k', map_options)
map('t', '<A-l>', '<C-\\><C-N><C-w>l', map_options)
map('i', '<A-h>', '<C-\\><C-N><C-w>h', map_options)
map('i', '<A-j>', '<C-\\><C-N><C-w>j', map_options)
map('i', '<A-k>', '<C-\\><C-N><C-w>k', map_options)
map('i', '<A-l>', '<C-\\><C-N><C-w>l', map_options)
map('n', '<A-h>', '<C-w>h', map_options)
map('n', '<A-j>', '<C-w>j', map_options)
map('n', '<A-k>', '<C-w>k', map_options)
map('n', '<A-l>', '<C-w>l', map_options)

-- Use alt+zuio to resize windows
map('n', '<A-z>', ':vertical resize -2<CR>', map_options)
map('n', '<A-u>', ':resize -2<CR>', map_options)
map('n', '<A-i>', ':resize +2<CR>', map_options)
map('n', '<A-o>', ':vertical resize +2<CR>', map_options)

-- Use alt+shift+jk to move lines up and down
map('n', '<A-J>', ':m .+1<CR>==', map_options)
map('n', '<A-K>', ':m .-2<CR>==', map_options)
map('i', '<A-J>', '<Esc>:m .+1<CR>==gi', map_options)
map('i', '<A-K>', '<Esc>:m .-2<CR>==gi', map_options)
map('v', '<A-J>', ':m \'>+1<CR>gv=gv', map_options)
map('v', '<A-K>', ':m \'<-2<CR>gv=gv', map_options)

-- Terminal
map('t', '<Esc>', '<C-\\><C-n>', map_options)
map("n", '<A-s>', '<Cmd> split term://zsh | resize 10 | setlocal nobuflisted <CR>', map_options)

-- Copying:
-- Primary
map('', '<Leader>Y', '"*y', map_options)
map('n', '<Leader>P', '"*p', map_options)
-- Clipboard
map('', '<Leader>y', '"+y', map_options)
map('n', '<Leader>p', '"+p', map_options)
map('', '<Leader>yy', '"+yy', map_options)

-- Bufferline
map('n', '<leader>n', ':BufferLineCycleNext<CR>', map_options)
map('n', '<leader>N', ':BufferLineCyclePrev<CR>', map_options)

-- Telescope
map('n', '<Leader>ff', '<Cmd>lua require("telescope.builtin").find_files()<CR>', map_options)
map('n', '<Leader>fg', '<Cmd>lua require("telescope.builtin").live_grep()<CR>',  map_options)
map('n', '<Leader>fb', '<Cmd>lua require("telescope.builtin").buffers()<CR>',    map_options)
map('n', '<Leader>fh', '<Cmd>lua require("telescope.builtin").help_tags()<CR>',  map_options)
map('n', '<Leader>fo', '<Cmd>lua require("telescope.builtin").oldfiles()<CR>',   map_options)

-- Autocomplete
map('i', '<CR>',  vim.fn['compe#confirm']('<CR>'), map_options)
map('i', '<C-e>', vim.fn['compe#close']('<C-e>'),  map_options)
map('i', '<Tab>',   'v:lua.tab_complete()',   { expr = true })
map('s', '<Tab>',   'v:lua.tab_complete()',   { expr = true })
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
-- Autopairs
map('i', '<CR>', 'v:lua.completions()', { expr=true, silent=true })

-- Language server
-- references
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', map_options)
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', map_options)
map('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', map_options)
map('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', map_options)
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', map_options)
map('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', map_options)
-- workspace
map('n', '<leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', map_options)
map('n', '<leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', map_options)
map('n', '<leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', map_options)
map('n', '<leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', map_options)
map('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', map_options)
-- diagnostics
map('n', '<leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', map_options)
map('n', 'dN', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', map_options)
map('n', 'dn', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', map_options)
map('n', '<leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', map_options)
-- formatting
map('n', '<leader>bf', '<Cmd>lua vim.lsp.buf.formatting()<CR>', map_options)
map('v', '<leader>bf', '<Cmd>lua vim.lsp.buf.range_formatting()<CR>', map_options)
