"     _    _ _                        _   _                      _
"    / \  | | |_ ___ _ __ _ __   __ _| |_(_)_   _____   ___  ___| |_ _   _ _ __
"   / _ \ | | __/ _ \ '__| '_ \ / _` | __| \ \ / / _ \ / __|/ _ \ __| | | | '_ \
"  / ___ \| | ||  __/ |  | | | | (_| | |_| |\ V /  __/ \__ \  __/ |_| |_| | |_) |
" /_/   \_\_|\__\___|_|  |_| |_|\__,_|\__|_| \_/ \___| |___/\___|\__|\__,_| .__/
"                                                                         |_|

let s:this_file   = resolve(expand('<sfile>:p'))
let s:this_dir    = fnamemodify(s:this_file, ':h')

" Source config
call execute('source ' . s:this_dir . '/config.vim')

"#############################################
"## Additional configuration                ##
"#############################################

" Different colorscheme
colorscheme NeoSolarized
set background=light

" Different statusline theme
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
