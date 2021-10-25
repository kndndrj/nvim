-------------------------
-- Telescope Settings: --
-------------------------
local no_binary_preview = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  require'plenary.job':new({
    command = 'file',
    args = { '--mime-type', '-b', filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], '/')[1]
      if mime_type == "text" then
        require'telescope.previewers'.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY FILE' })
        end)
      end
    end
  }):sync()
end

require'telescope'.setup {
  defaults = {
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
    prompt_prefix = ' ',
    color_devicons = true,

    file_previewer   = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer   = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = no_binary_preview,
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
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  auto_close = true,
  view = {
    width = 40,
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
        { key = "a",                                 cb = tree_cb("create") },
        { key = 'cw',                                cb = tree_cb('rename') },
        { key = "y",                                 cb = tree_cb("copy") },
        { key = "yw",                                cb = tree_cb("copy_name") },
        { key = "p",                                 cb = tree_cb("paste") },
        { key = {'<ESC>', 'q'},                      cb = tree_cb('close') },
        { key = '?',                                 cb = tree_cb('toggle_help') },
      }
    }
  }
}
