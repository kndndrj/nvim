" _ __   ___  _____   _(_)_ __ ___     ___ ___  _ __  / _(_) __ _
"| '_ \ / _ \/ _ \ \ / / | '_ ` _ \   / __/ _ \| '_ \| |_| |/ _` |
"| | | |  __/ (_) \ V /| | | | | | | | (_| (_) | | | |  _| | (_| |
"|_| |_|\___|\___/ \_/ |_|_| |_| |_|  \___\___/|_| |_|_| |_|\__, |
"                                                           |___/

"#############################################
"## Plugin Installation                     ##
"#############################################

call plug#begin("~/.vim/plugged")
    " Theme
    Plug 'rakr/vim-one', { 'as': 'one' }

    " Status line theme
    Plug 'itchyny/lightline.vim'

    " Language Client
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions =  ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-python', 'coc-eslint', 'coc-clangd', 'coc-sql', 'coc-tsserver', 'coc-vimtex']

    " TypeScript Highlighting
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    
    " File Explorer with Icons
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'

    " File Search
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    
    " Latex Live Preview
    Plug 'lervag/vimtex'
call plug#end()

"#############################################
"## Basic Settings                          ##
"#############################################

" Set relative numbers and a normal number on the current line
set number
set relativenumber

" Enable mouse commands
set mouse=a

" pyx version - python3
set pyx=3

" Give more space for displaying messages.
set cmdheight=2

" TextEdit might fail if hidden is not set.
set hidden

" Pressing the tab key in insert mode results in 4 space characters
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

set clipboard=unnamed

"#############################################
"## Visual Settings                         ##
"#############################################

" Enable themes
if (has("termguicolors"))
    set termguicolors
endif

" Theme
syntax enable
colorscheme one

" Statusline theme
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'one',
    \ }

" Highlight column 115 to easily maintain line length
set colorcolumn=115
highlight ColorColumn ctermbg=darkgray

"#############################################
"## COC Settings & Key Bindings             ##
"#############################################
"
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

"#############################################
"## NERDTree Settings & Key Bindings        ##
"#############################################

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Ignore NERDTree when quitting 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

"#############################################
"## FZF File Search Settings & Key Bindings ##
"#############################################

nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-i': 'split',
\ 'ctrl-s': 'vsplit'
\}
" requires silversearcher-ag
" used to ignore gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"#############################################
"## Other Key Bindings                      ##
"#############################################

" Exit terminal by pressing esc
tnoremap <Esc> <C-\><C-n>

" Use alt+hjkl to move between split/vsplit panels
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Use alt+c/v/x to interact with system clipboard + paste in insert mode
inoremap <A-p> <ESC>"+pa
nnoremap <A-p> <ESC>"+p
vnoremap <A-y> "+y
vnoremap <A-d> "+d

noremap <A-1> 1gt
noremap <A-1> 2gt
noremap <A-1> 3gt
noremap <A-1> 4gt
noremap <A-1> 5gt
noremap <A-1> 6gt
noremap <A-1> 7gt
noremap <A-1> 8gt
noremap <A-1> 9gt

"#############################################
"## Vimtex Settings                         ##
"#############################################

" Vimtex Flavor
let g:tex_flavor = 'latex'

" PDF viewer
let g:vimtex_view_method = 'zathura'
