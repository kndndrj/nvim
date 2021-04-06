"  _   _         __     ___                              __ _
" | \ | | ___  __\ \   / (_)_ __ ___     ___ ___  _ __  / _(_) __ _
" |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \   / __/ _ \| '_ \| |_| |/ _` |
" | |\  |  __/ (_) \ V / | | | | | | | | (_| (_) | | | |  _| | (_| |
" |_| \_|\___|\___/ \_/  |_|_| |_| |_|  \___\___/|_| |_|_| |_|\__, |
"                                                             |___/

"#############################################
"## Plugin Installation                     ##
"#############################################

call plug#begin("~/.vim/plugged")
    " Theme
    Plug 'rakr/vim-one', { 'as': 'one' }
    Plug 'overcache/NeoSolarized'

    " Status line theme and scrollbar
    Plug 'itchyny/lightline.vim'
    Plug 'ojroques/vim-scrollstatus'

    " Indent line indicator (see README.md for json),
    " with a script to detect indent to adjust ts, sw...
    Plug 'Yggdroot/indentLine'
    Plug 'ciaranm/detectindent'

    " Tab names
    Plug 'gcmt/taboo.vim'

    " Git integration
    Plug 'tpope/vim-fugitive'

    " Language Client
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " TypeScript Highlighting
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'

    " File Explorer with Icons
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'PhilRunninger/nerdtree-visual-selection'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " File Search
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    " Rust formatter
    Plug 'rust-lang/rust.vim'

    " Latex Live Preview
    Plug 'lervag/vimtex'
call plug#end()

"#############################################
"## Basic Settings                          ##
"#############################################

" Set leader key to space
let mapleader = " "

" Set relative numbers and a normal number on the current line
set number
set relativenumber

" Enable mouse commands
set mouse=a

" pyx version - python3
set pyxversion=3

" Give more space for displaying messages.
set cmdheight=2
 
" TextEdit might fail if hidden is not set.
set hidden

" Pressing the tab key in insert mode results in 4 space characters
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" open new split panes to right and below
set splitright
set splitbelow

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

"#############################################
"## Visual Settings                         ##
"#############################################

let g:taboo_tab_format = " %f%m │"

" Indent line indicator
let g:indentLine_char = '│'

" Detect indent level when entering a buffer window
autocmd BufWinEnter * :DetectIndent

" Enable themes
if (has("termguicolors"))
    set termguicolors
endif

" Theme
syntax enable
colorscheme one

" Statusline settings
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [ ['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified'] ],
    \   'right': [ ['lineinfo'], ['scroll'], ['fileformat', 'fileencoding', 'filetype'] ],
    \ },
    \ 'inactive': {
    \   'left': [ ['gitbranch', 'readonly', 'filename', 'modified'] ],
    \   'right': [ ['fileformat', 'fileencoding', 'filetype'] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead',
    \   'scroll': 'ScrollStatus',
    \ },
    \ }

" scrollbar symbols
let g:scrollstatus_symbol_track = ' '
let g:scrollstatus_symbol_bar = '='

" Highlight column 100 to easily maintain line length
set colorcolumn=100
highlight ColorColumn ctermbg=darkgray

"#############################################
"## COC Settings & Key Bindings             ##
"#############################################

" COC extensions
let g:coc_global_extensions =  [
    \ 'coc-emmet',
    \ 'coc-css',
    \ 'coc-yank',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-prettier',
    \ 'coc-python',
    \ 'coc-eslint',
    \ 'coc-clangd',
    \ 'coc-sql',
    \ 'coc-tsserver',
    \ 'coc-vimtex',
    \ 'coc-go',
    \ 'coc-rls',
    \ 'coc-lua'
    \ ]

" Command ':Prettier' formats current buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Coc-yank list binding
nnoremap <silent> <Leader>n  :<C-u>CocList -A --normal yank<cr>

"#############################################
"## NERDTree Settings & Key Bindings        ##
"#############################################

" Basic config
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeWinSize= 40
let g:NERDTreeDirArrowExpandable = '🠖'
let g:NERDTreeDirArrowCollapsible = '🠗'

" Toggle NERDTree
nnoremap <silent> <A-b> :NERDTreeToggle<CR>

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            endif
        endif
    endif
endfunction

" Hide Lightline on NERDTree
augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END
function s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfunction

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"#############################################
"## Telescope config                        ##
"#############################################

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' >',
        color_devicons = true,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}

require('telescope').load_extension('fzy_native')
EOF

"#############################################
"## Other Key Bindings                      ##
"#############################################

" Exit terminal by pressing esc, don't interfere with fzf
au TermOpen * tnoremap <Esc> <c-\><c-n>
au FileType fzf tunmap <Esc>

" Use alt+hjkl to move between panels
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Copying:
" Primary
noremap <Leader>Y "*y
noremap <Leader>P "*p
" Clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>yy "+yy

" alt + top keys for tab switching
noremap <A-q> 1gt
noremap <A-w> 2gt
noremap <A-e> 3gt
noremap <A-r> 4gt
noremap <A-t> 5gt
noremap <A-z> 6gt
noremap <A-u> 7gt
noremap <A-i> 8gt
noremap <A-o> 9gt
noremap <A-p> 10gt

"#############################################
"## Vimtex Settings                         ##
"#############################################

" Vimtex Flavor
let g:tex_flavor = 'latex'

" PDF viewer
let g:vimtex_view_method = 'zathura'

" Ignore annoying warnings
let g:vimtex_quickfix_ignore_filters = [
    \ 'Underfull \\hbox (badness [0-9]*) in ',
    \ 'Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in ',
    \ 'Package hyperref Warning: Token not allowed in a PDF string',
    \ 'Package typearea Warning: Bad type area settings!',
    \ ]
