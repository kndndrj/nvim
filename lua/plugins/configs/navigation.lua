-------------------------
-- Navigation: ----------
-------------------------

local M = {}

-- Telescope
local no_binary_preview = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  require("plenary.job")
    :new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
          require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
        else
          -- maybe we want to write something to the buffer here
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY FILE" })
          end)
        end
      end,
    })
    :sync()
end

function M.configure_telescope()
  require("telescope").setup {
    defaults = {
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      prompt_prefix = " ",
      color_devicons = true,

      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      buffer_previewer_maker = no_binary_preview,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  }

  require("telescope").load_extension("fzy_native")
  require("telescope").load_extension("notify")

  local map_options = { noremap = true, silent = true }

  vim.api.nvim_set_keymap("n", "<leader>ff", '<Cmd>lua require"telescope.builtin".find_files()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>fg", '<Cmd>lua require"telescope.builtin".live_grep()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>fb", '<Cmd>lua require"telescope.builtin".buffers()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>fh", '<Cmd>lua require"telescope.builtin".help_tags()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>fo", '<Cmd>lua require"telescope.builtin".oldfiles()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>fk", '<Cmd>lua require"telescope.builtin".file_browser()<CR>', map_options)
end

-- Harpoon
function M.configure_harpoon()
  local map_options = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "<leader>sa", '<Cmd>lua require"harpoon.mark".add_file()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>ss", '<Cmd>lua require"harpoon.ui".toggle_quick_menu()<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>sq", '<Cmd>lua require"harpoon.ui".nav_file(1)<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>sw", '<Cmd>lua require"harpoon.ui".nav_file(2)<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>se", '<Cmd>lua require"harpoon.ui".nav_file(3)<CR>', map_options)
  vim.api.nvim_set_keymap("n", "<leader>sr", '<Cmd>lua require"harpoon.ui".nav_file(3)<CR>', map_options)
  require("telescope").load_extension("harpoon")
end

-- Neotree
function M.configure_neotree()
  -- require("neo-tree").setup {
  --   close_if_last_window = true,
  --   window = {
  --     mapping_options = {
  --       noremap = true,
  --       nowait = true,
  --     },
  --     mappings = {
  --       ["<space>"] = {
  --         "toggle_node",
  --         nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
  --       },
  --       ["<2-LeftMouse>"] = "open",
  --       ["<cr>"] = "open",
  --       ["o"] = "open",
  --       ["<esc>"] = "revert_preview",
  --       ["P"] = { "toggle_preview", config = { use_float = true } },
  --       ["S"] = "open_split",
  --       ["s"] = "open_vsplit",
  --       ["t"] = "open_tabnew",
  --       ["w"] = "open_with_window_picker",
  --       ["C"] = "close_node",
  --       ["z"] = "close_all_nodes",
  --       --["Z"] = "expand_all_nodes",
  --       ["a"] = {
  --         "add",
  --         -- some commands may take optional config options, see `:h neo-tree-mappings` for details
  --         config = {
  --           show_path = "none", -- "none", "relative", "absolute"
  --         },
  --       },
  --       ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
  --       ["d"] = "delete",
  --       ["r"] = "rename",
  --       ["y"] = "copy_to_clipboard",
  --       ["x"] = "cut_to_clipboard",
  --       ["p"] = "paste_from_clipboard",
  --       ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
  --       -- ["c"] = {
  --       --  "copy",
  --       --  config = {
  --       --    show_path = "none" -- "none", "relative", "absolute"
  --       --  }
  --       --}
  --       ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
  --       ["q"] = "close_window",
  --       ["R"] = "refresh",
  --       ["?"] = "show_help",
  --       ["<"] = "prev_source",
  --       [">"] = "next_source",
  --     },
  --   },
  -- }

  local map_options = { noremap = true, silent = true }
  vim.keymap.set("n", "<leader>fj", ":Neotree<CR>", map_options)
end

return M
