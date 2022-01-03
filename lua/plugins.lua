-------------------------
-- Plugins: -------------
-------------------------
return require'packer'.startup(
  function()
    use 'wbthomason/packer.nvim'
    -- Indent lines
    use 'lukas-reineke/indent-blankline.nvim'
    use 'ciaranm/detectindent'
    -- Themes
    use 'sainnhe/everforest'
    use 'ful1e5/onedark.nvim'
    -- Lua dependencies
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    -- File tree
    use 'kyazdani42/nvim-tree.lua'
    -- Harpoon
    use 'ThePrimeagen/harpoon'
    -- TreeSitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    -- LSP settings
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    -- Autocompletion
    use 'windwp/nvim-autopairs'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'saadparwaiz1/cmp_luasnip'
    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'kndndrj/nvim-dap-projector'
    use 'mfussenegger/nvim-dap-python'
    -- Snippet manager
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    -- Statuslines
    use 'nvim-lualine/lualine.nvim'
    -- LaTeX
    use 'lervag/vimtex'
    -- Git
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
    -- tmux
    use 'alexghergh/nvim-tmux-navigation'
    -- database
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'
  end
)
