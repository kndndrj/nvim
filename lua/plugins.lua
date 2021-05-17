-------------------------
-- Plugins: -------------
-------------------------
return require'packer'.startup(
  function()
    use 'wbthomason/packer.nvim'
    -- Indent lines
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
    use 'ciaranm/detectindent'
    -- Themes
    use {'rakr/vim-one', as = 'one'}
    -- Lua dependencies
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    -- TreeSitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- LSP settings
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'onsails/lspkind-nvim'
    use 'windwp/nvim-autopairs'
    -- Snippet manager
    use 'hrsh7th/vim-vsnip'
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
    -- Debugging
    use 'puremourning/vimspector'
  end
)
