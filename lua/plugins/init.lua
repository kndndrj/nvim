-------------------------
-- Plugins: -------------
-------------------------

-- Bootstrap
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd 'packadd packer.nvim'
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


return require 'packer'.startup(
  function()
    use { 'wbthomason/packer.nvim' }

    -- Pretty
    use {
      'navarasu/onedark.nvim',
      config = function()

        require('onedark').setup {
          code_style = {
            strings = "NONE",
            comments = "italic",
            keywords = "bold,italic",
            functions = "NONE",
            variables = "NONE",
          },
          diagnostics = {
            darker = true,
            undercurl = true,
            background = true,
          },
        }

        vim.cmd 'colorscheme onedark'

        -- use tmux background (if not available from the theme)
        vim.cmd 'highlight Normal ctermbg=none guibg=none'
        vim.cmd 'highlight EndOfBuffer ctermbg=none guibg=none'
      end
    }
    use {
      'kyazdani42/nvim-web-devicons',
      module = 'nvim-web-devicons',
      config = function()
        require('nvim-web-devicons').setup { default = true }
      end,
    }
    use {
      'nvim-lualine/lualine.nvim',
      wants = 'nvim-web-devicons',
      config = function()
        require('plugins.configs.statusline').configure()
      end,
    }


    -- TreeSitter
    use {
      'nvim-treesitter/nvim-treesitter',
      opt = true,
      event = 'BufReadPre',
      run = ':TSUpdate',
      config = function()
        require('plugins.configs.treesitter').configure()
      end,
    }


    -- Utils
    use {
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufReadPre',
      config = function()
        require('plugins.configs.indentline').configure()
      end,
    }
    use { 'ciaranm/detectindent',
      event = 'BufReadPre',
      config = function()
        vim.api.nvim_create_autocmd('BufWinEnter', { command = ':DetectIndent' })
      end,
    }
    use { 'b3nj5m1n/kommentary',
      config = function()
        vim.g.kommentary_create_default_mappings = false

        require 'kommentary.config'.configure_language('default', {
          prefer_single_line_comments = true,
          use_consistent_indentation = true,
          ignore_whitespace = true,
        })
        vim.api.nvim_set_keymap('n', '<leader>zz', '<Plug>kommentary_line_default', {})
        vim.api.nvim_set_keymap('n', '<leader>z', '<Plug>kommentary_motion_default', {})
        vim.api.nvim_set_keymap('x', '<leader>z', '<Plug>kommentary_visual_default<C-c>', {})

      end,
    }
    use { 'NvChad/nvim-colorizer.lua',
      cmd = 'ColorizerToggle',
      config = function()
        require 'colorizer'.setup()
      end,
    }


    -- Navigation
    use {
      'nvim-telescope/telescope.nvim',
      opt = true,
      cmd = { 'Telescope' },
      module = { 'telescope', 'telescope.builtin' },
      keys = { '<leader>f' },
      config = function()
        require('plugins.configs.telescope').configure()
      end,
      wants = {
        'telescope-fzy-native.nvim',
        'popup.nvim',
        'plenary.nvim',
      },
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzy-native.nvim',
      },
    }
    use {
      'ThePrimeagen/harpoon',
      keys = { '<leader>s' },
      module = { 'harpoon', 'harpoon.cmd-ui', 'harpoon.mark', 'harpoon.ui', 'harpoon.term' },
      wants = { 'telescope.nvim' },
      requires = {
        'plenary.nvim'
      },
      config = function()
        local map_options = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', '<leader>sa', '<Cmd>lua require"harpoon.mark".add_file()<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>ss', '<Cmd>lua require"harpoon.ui".toggle_quick_menu()<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>sq', '<Cmd>lua require"harpoon.ui".nav_file(1)<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>sw', '<Cmd>lua require"harpoon.ui".nav_file(2)<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>se', '<Cmd>lua require"harpoon.ui".nav_file(3)<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>sr', '<Cmd>lua require"harpoon.ui".nav_file(3)<CR>', map_options)
        require('telescope').load_extension 'harpoon'
      end,
    }
    use {
      'alexghergh/nvim-tmux-navigation',
      config = function()
        require 'nvim-tmux-navigation'.setup {
          disable_when_zoomed = true
        }

        local map_options = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', '<C-a>h', ':lua require"nvim-tmux-navigation".NvimTmuxNavigateLeft()<cr>',
          map_options)
        vim.api.nvim_set_keymap('n', '<C-a>j', ':lua require"nvim-tmux-navigation".NvimTmuxNavigateDown()<cr>',
          map_options)
        vim.api.nvim_set_keymap('n', '<C-a>k', ':lua require"nvim-tmux-navigation".NvimTmuxNavigateUp()<cr>', map_options)
        vim.api.nvim_set_keymap('n', '<C-a>l', ':lua require"nvim-tmux-navigation".NvimTmuxNavigateRight()<cr>',
          map_options)
        vim.api.nvim_set_keymap('t', '<C-a>h', '<C-\\><C-N>:lua require"nvim-tmux-navigation".NvimTmuxNavigateLeft()<cr>'
          , map_options)
        vim.api.nvim_set_keymap('t', '<C-a>j', '<C-\\><C-N>:lua require"nvim-tmux-navigation".NvimTmuxNavigateDown()<cr>'
          , map_options)
        vim.api.nvim_set_keymap('t', '<C-a>k', '<C-\\><C-N>:lua require"nvim-tmux-navigation".NvimTmuxNavigateUp()<cr>',
          map_options)
        vim.api.nvim_set_keymap('t', '<C-a>l',
          '<C-\\><C-N>:lua require"nvim-tmux-navigation".NvimTmuxNavigateRight()<cr>', map_options)
        vim.api.nvim_set_keymap('i', '<C-a>h', '<C-\\><C-N>:lua require"nvim-tmux-navigation".NvimTmuxNavigateLeft()<cr>'
          , map_options)
        vim.api.nvim_set_keymap('i', '<C-a>j', '<C-\\><C-N>:lua require"nvim-tmux-navigation".NvimTmuxNavigateDown()<cr>'
          , map_options)
        vim.api.nvim_set_keymap('i', '<C-a>k', '<C-\\><C-N>:lua require"nvim-tmux-navigation".NvimTmuxNavigateUp()<cr>',
          map_options)
        vim.api.nvim_set_keymap('i', '<C-a>l',
          '<C-\\><C-N>:lua require"nvim-tmux-navigation".NvimTmuxNavigateRight()<cr>', map_options)
      end,
    }


    -- LSP
    use {
      'neovim/nvim-lspconfig',
      opt = true,
      event = { 'BufReadPre' },
      wants = {
        'cmp-nvim-lsp',
      },
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
      },
      config = function()
        require('plugins.configs.lsp').configure()
      end,
    }


    -- DAP
    use {
      'mfussenegger/nvim-dap',
      opt = true,
      keys = { 'č' },
      wants = {
        'nvim-dap-virtual-text',
        'nvim-dap-ui',
        'nvim-dap-python',
        'nvim-projector',
      },
      requires = {
        'theHamsta/nvim-dap-virtual-text',
        'rcarriga/nvim-dap-ui',
        'mfussenegger/nvim-dap-python',
        { 'kndndrj/nvim-projector', branch = 'development' },
      },
      config = function()
        require('plugins.configs.dap').configure()
      end,
    }


    -- Snippets
    use {
      'L3MON4D3/LuaSnip',
      opt = true,
      wants = { 'friendly-snippets', 'vim-snippets' },
      requires = {
        'rafamadriz/friendly-snippets',
        'honza/vim-snippets',
      },
      config = function()
        -- Load external snippets
        require 'luasnip.loaders.from_vscode'.lazy_load()


        local map_options = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('i', '<C-d>', '<Cmd>lua require"luasnip".jump(-1)<CR>', map_options)
        vim.api.nvim_set_keymap('s', '<C-d>', '<Cmd>lua require"luasnip".jump(-1)<CR>', map_options)
        vim.api.nvim_set_keymap('i', '<C-f>', '<Cmd>lua require"luasnip".jump(1)<CR>', map_options)
        vim.api.nvim_set_keymap('s', '<C-f>', '<Cmd>lua require"luasnip".jump(1)<CR>', map_options)
      end,
    }


    -- Completion
    --
    use {
      'windwp/nvim-autopairs',
      opt = true,
      event = 'InsertEnter',
      wants = 'nvim-treesitter',
      module = { 'nvim-autopairs.completion.cmp', 'nvim-autopairs' },
      config = function()
        require 'nvim-autopairs'.setup {
          check_ts = true
        }
      end,
    }
    use {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      opt = true,
      config = function()
        require('plugins.configs.completion').configure()
      end,
      wants = { 'LuaSnip', 'lspkind-nvim' },
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind-nvim',
      },
    }


    -- Git
    use {
      'tpope/vim-fugitive',
      opt = true,
      cmd = { 'G', 'Git', 'GBrowse', 'Gdiffsplit', 'Gvdiffsplit' },
      requires = {
        'tpope/vim-rhubarb',
        'idanarye/vim-merginal',
      },
      config = function()
        local map_options = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', '<leader>vd', ':diffget //2<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>vj', ':diffget //3<CR>', map_options)
      end
    }
    use {
      'lewis6991/gitsigns.nvim',
      event = 'BufReadPre',
      wants = {
        'plenary.nvim',
      },
      requires = {
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require 'gitsigns'.setup {
          keymaps = {},
        }
        local map_options = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', '<leader>hs', '<Cmd>lua require"gitsigns".stage_hunk()<CR>', map_options)
        vim.api.nvim_set_keymap('v', '<leader>hs',
          '<Cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hu', '<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hr', '<Cmd>lua require"gitsigns".reset_hunk()<CR>', map_options)
        vim.api.nvim_set_keymap('v', '<leader>hr',
          '<Cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hR', '<Cmd>lua require"gitsigns".reset_buffer()<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hp', '<Cmd>lua require"gitsigns".preview_hunk()<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hb', '<Cmd>lua require"gitsigns".blame_line(true)<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hS', '<Cmd>lua require"gitsigns".stage_buffer()<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hU', '<Cmd>lua require"gitsigns".reset_buffer_index()<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hi', '<Cmd>lua require"gitsigns.actions".select_hunk()<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hn', '<Cmd>lua require"gitsigns".next_hunk()<CR>', map_options)
        vim.api.nvim_set_keymap('n', '<leader>hN', '<Cmd>lua require"gitsigns".prev_hunk()<CR>', map_options)
      end,
    }


    -- Database
    use {
      'tpope/vim-dadbod',
      opt = true,
      cmd = { 'DBUIToggle', 'DBUI', 'DBUIAddConnection', 'DBUIFindBuffer', 'DBUIRenameBuffer', 'DBUILastQueryInfo' },
      keys = { 'čq' },
      requires = {
        'kristijanhusak/vim-dadbod-ui',
        'kristijanhusak/vim-dadbod-completion',
      },
      config = function()
        vim.g.db_ui_use_nerd_fonts = 1

        local map_options = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', 'čq', ':DBUIToggle<CR>', map_options)
      end,
    }


    -- LaTeX
    use {
      'lervag/vimtex',
      config = function()
        require('plugins.configs.vimtex').configure()
      end
    }


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end
)
