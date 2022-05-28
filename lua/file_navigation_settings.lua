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
