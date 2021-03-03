let s:this_file   = resolve(expand('<sfile>:p'))
let s:this_dir    = fnamemodify(s:this_file, ':h')

call execute('source ' . s:this_dir . '/default.vim')

" Different colorscheme
colorscheme NeoSolarized
set background=light

" Statusline theme
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ }
