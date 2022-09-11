-----------------------
-- Init.lua -----------
-----------------------
-- Macros
local cmd = vim.cmd
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.o
local wo = vim.wo

-- Source other configs
require 'plugins'

-----------------------
-- Basic Config: ------
-----------------------
o.hidden = true

-- Split defaults
o.splitbelow = true
o.splitright = true

-- Display line numbers
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

-- Always show the signcolumn
wo.signcolumn = 'yes'

-- Tab (key) settings
o.tabstop = 4
o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.smarttab = true

-- Highlight a column to easily maintain line length
wo.colorcolumn = '100'

-- any combination of 'wq' works
cmd ':command! WQ wq'
cmd ':command! Wq wq'
cmd ':command! Wqa wqa'
cmd ':command! W w'
cmd ':command! Q q'

-- Autocommands
cmd 'autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}'
cmd 'autocmd BufNewFile,BufRead *.groff set filetype=groff'
cmd 'autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy'
cmd 'autocmd BufWinEnter,WinEnter term://* startinsert'


-----------------------
-- Key Bindings: ------
-----------------------
-- Binding options
local map_options = { noremap = true, silent = true }

-- Map leader to space
g.mapleader = ' '

-- <leader>Escape key functions
map('n', '<leader><esc>', ':cclose<CR>', map_options)

-- Cycle quickfix lists
map('n', '<leader>j', ':cnext<CR>', map_options)
map('n', '<leader>k', ':cprev<CR>', map_options)
map('n', '<leader>o', ':copen<CR>', map_options)

-- Cycle buffers
map('n', '<leader>n', ':bnext<CR>', map_options)
map('n', '<leader>N', ':bprev<CR>', map_options)

-- Fixes for the US layout
map('n', 'š', '[', map_options)
map('n', 'đ', ']', map_options)
map('n', 'Š', '{', map_options)
map('n', 'Đ', '}', map_options)

-- Clever remaps
map('n', 'n', 'nzzzv', map_options)
map('n', 'N', 'Nzzzv', map_options)
map('v', '//', 'y/\\V<C-R>=escape(@","/\")<CR><CR>', map_options)


-- Use alt+zuio to resize windows in any mode
map('n', '<A-z>', ':vertical resize -2<CR>', map_options)
map('n', '<A-u>', ':resize +2<CR>', map_options)
map('n', '<A-i>', ':resize -2<CR>', map_options)
map('n', '<A-o>', ':vertical resize +2<CR>', map_options)
map('i', '<A-z>', '<C-\\><C-N>:vertical resize -2<CR>i', map_options)
map('i', '<A-u>', '<C-\\><C-N>:resize -2<CR>i', map_options)
map('i', '<A-i>', '<C-\\><C-N>:resize +2<CR>i', map_options)
map('i', '<A-o>', '<C-\\><C-N>:vertical resize +2<CR>i', map_options)
map('t', '<A-z>', '<C-\\><C-N>:vertical resize -2<CR>i', map_options)
map('t', '<A-u>', '<C-\\><C-N>:resize -2<CR>i', map_options)
map('t', '<A-i>', '<C-\\><C-N>:resize +2<CR>i', map_options)
map('t', '<A-o>', '<C-\\><C-N>:vertical resize +2<CR>i', map_options)

-- Use alt+shift+jk to move lines up and down
map('n', '<A-J>', ':m .+1<CR>==', map_options)
map('n', '<A-K>', ':m .-2<CR>==', map_options)
map('i', '<A-J>', '<Esc>:m .+1<CR>==gi', map_options)
map('i', '<A-K>', '<Esc>:m .-2<CR>==gi', map_options)
map('v', '<A-J>', ':m \'>+1<CR>gv=gv', map_options)
map('v', '<A-K>', ':m \'<-2<CR>gv=gv', map_options)

-- Terminal
map('t', '<Esc>', '<C-\\><C-n>', map_options)
map('n', '<A-s>', '<Cmd> split term://zsh | resize 10 | setlocal nobuflisted <CR>', map_options)

-- Clipboard
-- y
map('', '<leader>y', '"+y', map_options)
map('n', '<leader>yy', '"+yy', map_options)
map('n', '<leader>Y', '"+y$', map_options)
map('n', '<leader>yi', '"+yi', map_options)
map('n', '<leader>ya', '"+ya', map_options)
-- d
map('v', '<leader>d', '"+d', map_options)
map('n', '<leader>dd', '"+dd', map_options)
map('n', '<leader>D', '"+d$', map_options)
map('n', '<leader>di', '"+di', map_options)
map('n', '<leader>da', '"+da', map_options)
-- p
map('', '<leader>p', '"+p', map_options)

