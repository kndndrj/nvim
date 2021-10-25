require 'plugins'
require 'file_navigation_settings'
require 'indentline_settings'
require 'lsp_settings'
require 'vimtex_settings'
require 'treesitter_settings'
require 'debug_settings'

-- Macros
local cmd = vim.cmd
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.o
local wo = vim.wo

-----------------------
-- Basic Config: ------
-----------------------

o.hidden = true

-- Split defaults
o.splitbelow = true
o.splitright = true

-- Enable colors
o.termguicolors = true

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

-- Tab (key) settings
o.tabstop = 4
o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.smarttab = true

-- Highlight a column to easily maintain line length
wo.colorcolumn = '100'
o.textwidth = 99

-- any combination of 'wq' works
cmd ':command! WQ wq'
cmd ':command! Wq wq'
cmd ':command! Wqa wqa'
cmd ':command! W w'
cmd ':command! Q q'

-- Autocommands
cmd 'autocmd BufWinEnter * :DetectIndent'
cmd 'autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}'
cmd 'autocmd BufNewFile,BufRead *.groff set filetype=groff'
cmd 'autocmd BufWinEnter,WinEnter term://* startinsert'

-- Git signs setup
require'gitsigns'.setup {
  keymaps = {},
}

-- Scroll bar
g.scrollview_excluded_filetypes = {
  'NvimTree',
  'dap-repl',
  'dapui_scopes',
  'dapui_breakpoints',
  'dapui_stacks',
  'dapui_watches',
}

-----------------------
-- Key Bindings: ------
-----------------------

-- Binding options
local map_options = { noremap=true, silent=true }

-- Map leader to space
g.mapleader = ' '

-- <leader>Escape key functions
map('n', '<leader><esc>', ':cclose<CR> :nohlsearch<CR>', map_options)

-- Cycle quickfix lists
map('n', '<leader>j', ':cnext<CR>', map_options)
map('n', '<leader>k', ':cprev<CR>', map_options)
map('n', '<leader>o', ':copen<CR>', map_options)

-- Fixes for the US layout
map('n', 'š', '[', map_options)
map('n', 'đ', ']', map_options)
map('n', 'Š', '{', map_options)
map('n', 'Đ', '}', map_options)

-- Clever remaps
map('n', 'Y', 'y$', map_options)
map('n', 'n', 'nzzzv', map_options)
map('n', 'N', 'Nzzzv', map_options)

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
map('', '<leader>y', '"+y', map_options)
map('', '<leader>p', '"+p', map_options)
map('n', '<leader>yy', '"+yy', map_options)
map('n', '<leader>Y', '"+y$', map_options)

-- Gitsigns
map('n', '<leader>hs', '<Cmd>lua require"gitsigns".stage_hunk()<CR>', map_options)
map('v', '<leader>hs', '<Cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', map_options)
map('n', '<leader>hu', '<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>', map_options)
map('n', '<leader>hr', '<Cmd>lua require"gitsigns".reset_hunk()<CR>', map_options)
map('v', '<leader>hr', '<Cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', map_options)
map('n', '<leader>hR', '<Cmd>lua require"gitsigns".reset_buffer()<CR>', map_options)
map('n', '<leader>hp', '<Cmd>lua require"gitsigns".preview_hunk()<CR>', map_options)
map('n', '<leader>hb', '<Cmd>lua require"gitsigns".blame_line(true)<CR>', map_options)
map('n', '<leader>hS', '<Cmd>lua require"gitsigns".stage_buffer()<CR>', map_options)
map('n', '<leader>hU', '<Cmd>lua require"gitsigns".reset_buffer_index()<CR>', map_options)
map('n', '<leader>hi', '<Cmd>lua require"gitsigns.actions".select_hunk()<CR>', map_options)

-- Vim Fugitive
map('n', '<leader>vd', ':diffget //2<CR>', map_options)
map('n', '<leader>vj', ':diffget //3<CR>', map_options)

-- Telescope
map('n', '<leader>ff', '<Cmd>lua require"telescope.builtin".find_files()<CR>', map_options)
map('n', '<leader>fg', '<Cmd>lua require"telescope.builtin".live_grep()<CR>',  map_options)
map('n', '<leader>fb', '<Cmd>lua require"telescope.builtin".buffers()<CR>',    map_options)
map('n', '<leader>fh', '<Cmd>lua require"telescope.builtin".help_tags()<CR>',  map_options)
map('n', '<leader>fo', '<Cmd>lua require"telescope.builtin".oldfiles()<CR>',   map_options)
map('n', '<leader>fk', '<Cmd>lua require"telescope.builtin".file_browser()<CR>',   map_options)

-- Nvim tree
map('n', '<leader>fj', ':NvimTreeToggle<CR>', map_options)

-- Snippets
map('i', '<C-d>', '<Cmd>lua require"luasnip".jump(-1)<CR>', map_options)
map('s', '<C-d>', '<Cmd>lua require"luasnip".jump(-1)<CR>', map_options)
map('i', '<C-f>', '<Cmd>lua require"luasnip".jump(1)<CR>', map_options)
map('s', '<C-f>', '<Cmd>lua require"luasnip".jump(1)<CR>', map_options)

-- Language server
-- references
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', map_options)
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', map_options)
map('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', map_options)
map('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', map_options)
map('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', map_options)
-- formatting
map('n', '<leader>tt', '<Cmd>lua vim.lsp.buf.formatting()<CR>', map_options)
-- LSP Saga
-- lsp provider
map('n', 'gh', '<Cmd>lua require"lspsaga.provider".lsp_finder()<CR>', map_options)
-- rename
map('n', 'gn', '<Cmd>lua require"lspsaga.rename".rename()<CR>', map_options)
-- code action
map('n', '<leader>ca', '<Cmd>lua require"lspsaga.codeaction".code_action()<CR>', map_options)
map('v', '<leader>ca', ':<C-U>lua require"lspsaga.codeaction".range_code_action()<CR>', map_options)
-- hover
map('n', 'K', '<Cmd>lua require"lspsaga.hover".render_hover_doc()<CR>', map_options)
map('n', '<C-k>', '<Cmd>lua require"lspsaga.signaturehelp".signature_help()<CR>', map_options)
-- diagnostic
map('n', 'de', '<Cmd>lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>', map_options)
map('n', 'dN', '<Cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>', map_options)
map('n', 'dn', '<Cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>', map_options)

-- Debugger
-- core
map('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', map_options)
map('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', map_options)
map('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', map_options)
map('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', map_options)
map('n', '<leader>b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', map_options)
map('n', '<leader>B', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', map_options)
map('n', '<leader>lp', '<Cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', map_options)
map('n', '<leader>dr', '<Cmd>lua require"dap".repl.open()<CR>', map_options)
map('n', '<leader>dl', '<Cmd>lua require"dap".run_last()<CR>', map_options)
map('n', '<leader>dt', '<Cmd>lua Add_test_to_configurations()<CR>', map_options)
-- dap-ui
map('n', '<F2>', '<Cmd>lua require"dapui".toggle()<CR>', map_options)
map('v', '<leader>ee', '<Cmd>lua require("dapui").eval()<CR>', map_options)
-- dap-python
map('n', '<leader>dn', '<Cmd>lua require("dap-python").test_method()<CR>', map_options)
map('n', '<leader>df', '<Cmd>lua require("dap-python").test_class()<CR>', map_options)
map('v', '<leader>ds', '<ESC><Cmd>lua require("dap-python").debug_selection()<CR>', map_options)
