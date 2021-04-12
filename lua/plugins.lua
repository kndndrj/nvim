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
    -- Lua dependencies
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
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
    -- Misc
    use 'lewis6991/gitsigns.nvim'
  end
)
