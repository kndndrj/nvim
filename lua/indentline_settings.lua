-------------------------
-- Indent Line: ---------
-------------------------
local g = vim.g

g.indent_blankline_filetype_exclude = {'help', 'terminal'}
g.indent_blankline_buftype_exclude = {'terminal'}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

g.indent_blankline_use_treesitter = true
g.indent_blankline_show_current_context = true
g.indent_blankline_context_highlight_list = '["Error", "Warning"]'
