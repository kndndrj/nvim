-------------------------
-- Plugins: -------------
-------------------------

-- Bootstrap
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function()
  use { "wbthomason/packer.nvim" }

  -- Pretty
  use {
    "navarasu/onedark.nvim",
    config = function()
      require("plugins.configs.candy").configure_colorscheme()
    end,
  }
  use {
    "stevearc/dressing.nvim",
    config = function()
      require("plugins.configs.candy").configure_dressing()
    end,
  }
  use {
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.configs.candy").configure_notify()
    end,
  }
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup { default = true }
    end,
  }
  use {
    "nvim-lualine/lualine.nvim",
    wants = "nvim-web-devicons",
    config = function()
      require("plugins.configs.statusline").configure()
    end,
  }

  -- TreeSitter
  use {
    "nvim-treesitter/nvim-treesitter",
    opt = true,
    event = "BufReadPre",
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter").configure()
    end,
  }

  -- Utils
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("plugins.configs.indentline").configure()
    end,
  }
  use {
    "ciaranm/detectindent",
    event = "BufReadPre",
    config = function()
      vim.api.nvim_create_autocmd("BufWinEnter", { command = ":DetectIndent" })
    end,
  }
  use {
    "b3nj5m1n/kommentary",
    config = function()
      require("plugins.configs.comments").configure()
    end,
  }
  use {
    "NvChad/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require("colorizer").setup()
    end,
  }

  -- Navigation
  use {
    "nvim-telescope/telescope.nvim",
    opt = true,
    cmd = { "Telescope" },
    module = { "telescope", "telescope.builtin" },
    keys = { "<leader>f" },
    wants = {
      "telescope-fzy-native.nvim",
      "popup.nvim",
      "plenary.nvim",
      "nvim-notify",
    },
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
    config = function()
      require("plugins.configs.navigation").configure_telescope()
    end,
  }
  use {
    "ThePrimeagen/harpoon",
    keys = { "<leader>s" },
    module = {
      "harpoon",
      "harpoon.cmd-ui",
      "harpoon.mark",
      "harpoon.ui",
      "harpoon.term",
    },
    wants = { "telescope.nvim" },
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.configs.navigation").configure_harpoon()
    end,
  }
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    opt = true,
    cmd = { "Neotree" },
    keys = { "<leader>fj" },
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.configs.navigation").configure_neotree()
    end,
  }

  -- Tmux
  use {
    "aserowy/tmux.nvim",
    wants = {
      "nvim-libmodal",
    },
    requires = {
      "Iron-E/nvim-libmodal",
    },
    config = function()
      require("plugins.configs.tmux").configure()
    end,
  }

  -- Mason
  use {
    "williamboman/mason.nvim",
    wants = {
      "mason-lspconfig.nvim",
      "mason-nvim-dap.nvim",
      "mason-update-all",
      "mason-null-ls.nvim",
    },
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "jayp0521/mason-nvim-dap.nvim",
      "jayp0521/mason-null-ls.nvim",
      "RubixDev/mason-update-all",
    },
    run = ":MasonUpdateAll",
    config = function()
      require("plugins.configs.mason").configure()

      -- get nullls sources
      local nullls = {}
      for _, srcs in pairs(require("plugins.configs.nullls.sources")) do
        for src, _ in pairs(srcs) do
          table.insert(nullls, src)
        end
      end

      require("plugins.configs.mason").install(
        vim.tbl_keys(require("plugins.configs.lsp.servers")),
        vim.tbl_keys(require("plugins.configs.debug.adapters")),
        nullls
      )
    end,
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    opt = true,
    event = { "BufReadPre" },
    after = "mason.nvim",
    wants = {
      "cmp-nvim-lsp",
      "trouble.nvim",
    },
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      { "folke/trouble.nvim", opt = true },
    },
    config = function()
      require("plugins.configs.lsp").configure()
    end,
  }

  -- NULL-LS
  use {
    "jose-elias-alvarez/null-ls.nvim",
    opt = true,
    event = { "BufReadPre" },
    wants = {
      "cmp-nvim-lsp",
    },
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.configs.nullls").configure()
    end,
  }

  -- DAP
  use {
    "mfussenegger/nvim-dap",
    opt = true,
    keys = { "č" },
    module = "dap",
    after = "mason.nvim",
    wants = {
      "nvim-dap-virtual-text",
      "nvim-dap-ui",
      "nvim-dap-python",
      "nvim-projector",
    },
    requires = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      { "kndndrj/nvim-projector", branch = "development" },
      "kndndrj/projector-loader-vscode",
    },
    config = function()
      require("plugins.configs.debug").configure()
    end,
  }

  -- Snippets
  use {
    "L3MON4D3/LuaSnip",
    opt = true,
    wants = { "friendly-snippets", "vim-snippets" },
    requires = {
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },
    config = function()
      require("plugins.configs.snippets").configure()
    end,
  }

  -- Completion
  use {
    "windwp/nvim-autopairs",
    opt = true,
    event = "InsertEnter",
    wants = "nvim-treesitter",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    config = function()
      require("nvim-autopairs").setup {
        check_ts = true,
      }
    end,
  }
  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("plugins.configs.completion").configure()
    end,
    wants = { "LuaSnip", "lspkind-nvim", "nvim-autopairs" },
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
    },
  }

  -- Git
  use {
    "tpope/vim-fugitive",
    opt = true,
    cmd = { "G", "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
    requires = {
      "tpope/vim-rhubarb",
      "idanarye/vim-merginal",
    },
    config = function()
      require("plugins.configs.git").configure_fugitive()
    end,
  }
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = {
      "plenary.nvim",
    },
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.configs.git").configure_gitsigns()
    end,
  }

  -- Database
  use {
    "tpope/vim-dadbod",
    opt = true,
    cmd = {
      "DBUIToggle",
      "DBUI",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
    },
    requires = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  }

  -- LaTeX
  use {
    "lervag/vimtex",
    config = function()
      require("plugins.configs.vimtex").configure()
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
