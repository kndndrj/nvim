-----------------------
-- Plugins: -----------
-----------------------
return require("packer").startup(
    function()
        use 'wbthomason/packer.nvim'
        -- Indent lines
        use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
        use 'ciaranm/detectindent'
        -- Themes
        use {'rakr/vim-one', as = 'one'}
        use 'overcache/NeoSolarized'
        -- Telescope
        use 'nvim-lua/popup.nvim'
        use 'nvim-lua/plenary.nvim'
        use 'nvim-telescope/telescope.nvim'
        use 'nvim-telescope/telescope-fzy-native.nvim'
        -- LSP settings
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/nvim-compe'
        use 'onsails/lspkind-nvim'
        use 'windwp/nvim-autopairs'
        -- Snippet manager
        use 'hrsh7th/vim-vsnip'
    end
)
