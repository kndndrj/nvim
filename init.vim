"  ____        __             _ _              _
" |  _ \  ___ / _| __ _ _   _| | |_   ___  ___| |_ _   _ _ __
" | | | |/ _ \ |_ / _` | | | | | __| / __|/ _ \ __| | | | '_ \
" | |_| |  __/  _| (_| | |_| | | |_  \__ \  __/ |_| |_| | |_) |
" |____/ \___|_|  \__,_|\__,_|_|\__| |___/\___|\__|\__,_| .__/
"                                                       |_|

let s:this_file   = resolve(expand('<sfile>:p'))
let s:this_dir    = fnamemodify(s:this_file, ':h')

" Source config
call execute('source ' . s:this_dir . '/config.vim')

"#############################################
"## Additional configuration                ##
"#############################################

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
