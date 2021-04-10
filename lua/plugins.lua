--------------------
-- Plugins: --------
--------------------

-- using { } when using a different branch of the plugin or loading the plugin with certain commands
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
    end
)
