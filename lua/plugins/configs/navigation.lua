-------------------------
-- Navigation: ----------
-------------------------

local M = {}

-- Telescope
local no_binary_preview = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  require 'plenary.job':new({
    command = 'file',
    args = { '--mime-type', '-b', filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], '/')[1]
      if mime_type == 'text' then
        require 'telescope.previewers'.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY FILE' })
        end)
      end
    end
  }):sync()
end

function M.configure_telescope()

  require 'telescope'.setup {
    defaults = {
      file_sorter = require 'telescope.sorters'.get_fzy_sorter,
      prompt_prefix = ' ',
      color_devicons = true,

      file_previewer         = require 'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer         = require 'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer       = require 'telescope.previewers'.vim_buffer_qflist.new,
      buffer_previewer_maker = no_binary_preview,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    }
  }

  require 'telescope'.load_extension('fzy_native')


  local map_options = { noremap = true, silent = true }

  vim.api.nvim_set_keymap('n', '<leader>ff', '<Cmd>lua require"telescope.builtin".find_files()<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>fg', '<Cmd>lua require"telescope.builtin".live_grep()<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>fb', '<Cmd>lua require"telescope.builtin".buffers()<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>fh', '<Cmd>lua require"telescope.builtin".help_tags()<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>fo', '<Cmd>lua require"telescope.builtin".oldfiles()<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>fk', '<Cmd>lua require"telescope.builtin".file_browser()<CR>', map_options)

end

-- Harpoon
function M.configure_harpoon()

  local map_options = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', '<leader>sa', '<Cmd>lua require"harpoon.mark".add_file()<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>ss', '<Cmd>lua require"harpoon.ui".toggle_quick_menu()<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>sq', '<Cmd>lua require"harpoon.ui".nav_file(1)<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>sw', '<Cmd>lua require"harpoon.ui".nav_file(2)<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>se', '<Cmd>lua require"harpoon.ui".nav_file(3)<CR>', map_options)
  vim.api.nvim_set_keymap('n', '<leader>sr', '<Cmd>lua require"harpoon.ui".nav_file(3)<CR>', map_options)
  require('telescope').load_extension 'harpoon'

end

return M
