let s:this_file   = resolve(expand('<sfile>:p'))
let s:this_dir    = fnamemodify(s:this_file, ':h')

call execute('source ' . s:this_dir . '/default.vim')

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
