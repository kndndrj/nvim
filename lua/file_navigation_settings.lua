-------------------------
-- Telescope Settings: --
-------------------------
require'telescope'.setup {
  defaults = {
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,

    file_previewer   = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer   = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

require'telescope'.load_extension('fzy_native')

-------------------------
-- Nvim tree settings: --
-------------------------
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = {'<CR>', 'l', 'o', '<2-LeftMouse>'}, cb = tree_cb('edit') },
        { key = {'<2-RightMouse>', 'cd'},            cb = tree_cb('cd') },
        { key = '<C-v>',                             cb = tree_cb('vsplit') },
        { key = '<C-x>',                             cb = tree_cb('split') },
        { key = '<C-t>',                             cb = tree_cb('tabnew') },
        { key = 'P',                                 cb = tree_cb('parent_node') },
        { key = {'<BS>', 'h'},                       cb = tree_cb('close_node') },
        { key = 'K',                                 cb = tree_cb('first_sibling') },
        { key = 'J',                                 cb = tree_cb('last_sibling') },
        { key = 'R',                                 cb = tree_cb('refresh') },
        { key = 'cw',                                cb = tree_cb('rename') },
        { key = {'<ESC>', 'q'},                       cb = tree_cb('close') },
        { key = '?',                                cb = tree_cb('toggle_help') },
      }
    }
  }
}

