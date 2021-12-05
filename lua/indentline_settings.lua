-------------------------
-- Indent Line: ---------
-------------------------
require'indent_blankline'.setup {
    buftype_exclude = { 'terminal' },
    filetype_exclude = { 'help', 'terminal' },

    show_trailing_blankline_indent = false,
    show_first_indent_level = false,

    use_treesitter = true,
    show_current_context = true,
    context_highlight_list = { 'Warning' }
}
