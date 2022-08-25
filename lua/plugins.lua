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
    -- Lua dependencies
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
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
    use {'kndndrj/nvim-projector', branch='development'}
    use 'mfussenegger/nvim-dap-python'
    -- Snippet manager
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    -- Icons and color previews
    use 'kyazdani42/nvim-web-devicons'
    use 'NvChad/nvim-colorizer.lua'
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
    -- comments
    use 'b3nj5m1n/kommentary'
  end
)
