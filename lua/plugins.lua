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
    use {'rakr/vim-one', as = 'one'}
    use 'ful1e5/onedark.nvim'
    -- Lua dependencies
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    -- File tree
    use 'kyazdani42/nvim-tree.lua'
    -- TreeSitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    -- LSP settings
    use 'neovim/nvim-lspconfig'
    use 'rinx/lspsaga.nvim'
    use 'hrsh7th/nvim-compe'
    use 'onsails/lspkind-nvim'
    use 'windwp/nvim-autopairs'
    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'mfussenegger/nvim-dap-python'
    -- Snippet manager
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    -- Statuslines
    use 'akinsho/nvim-bufferline.lua'
    use 'glepnir/galaxyline.nvim'
    use 'dstein64/nvim-scrollview'
    use 'karb94/neoscroll.nvim'
    -- LaTeX
    use 'lervag/vimtex'
    -- Git
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
  end
)
