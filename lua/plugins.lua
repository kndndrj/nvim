-------------------------
-- Plugins: -------------
-------------------------
local M = {}

function M.configure()
  local plugins = {
    { "folke/lazy.nvim" },

    -- Pretty
    {
      "navarasu/onedark.nvim",
      config = function()
        require("plugins.candy").configure_colorscheme()
      end,
    },
    {
      "stevearc/dressing.nvim",
      config = function()
        require("plugins.candy").configure_dressing()
      end,
    },
    {
      "rcarriga/nvim-notify",
      config = function()
        require("plugins.candy").configure_notify()
      end,
    },
    {
      "startup-nvim/startup.nvim",
      dependencies = {
        -- "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("plugins.candy").configure_greeting()
      end,
    },
    {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        -- "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("plugins.statusline").configure()
      end,
    },

    -- TreeSitter
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufReadPre",
      build = ":TSUpdate",
      config = function()
        require("plugins.treesitter").configure()
      end,
    },

    -- Utils
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("plugins.indentline").configure()
      end,
    },
    {
      "ciaranm/detectindent",
      event = "BufReadPre",
      config = function()
        vim.api.nvim_create_autocmd("BufWinEnter", { command = ":DetectIndent" })
      end,
    },
    {
      "b3nj5m1n/kommentary",
      config = function()
        require("plugins.comments").configure()
      end,
    },
    {
      "NvChad/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
        require("colorizer").setup()
      end,
    },

    -- Navigation
    {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      keys = { "<leader>f" },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        -- "rcarriga/nvim-notify"
      },
      config = function()
        require("plugins.navigation").configure_telescope()
      end,
    },
    {
      "ThePrimeagen/harpoon",
      keys = { "<leader>s" },
      dependencies = {
        -- "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("plugins.navigation").configure_harpoon()
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        -- "kyazdani42/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("plugins.navigation").configure_neotree()
      end,
    },

    -- Tmux
    {
      "aserowy/tmux.nvim",
      dependencies = {
        "Iron-E/nvim-libmodal",
      },
      config = function()
        require("plugins.tmux").configure()
      end,
    },

    -- Mason
    {
      "williamboman/mason.nvim",
      dependencies = {
        "RubixDev/mason-update-all",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
      },
      build = ":MasonUpdateAll",
      config = function()
        -- Initialize meson
        require("mason").setup()
        -- register update cmd
        require("mason-update-all").setup()
        -- Install extra packages
        require("mason-tool-installer").setup {
          ensure_installed = { "shellcheck", "golangci-lint", "latexindent" },
        }
      end,
    },

    -- LSP
    {
      "neovim/nvim-lspconfig",
      event = "BufReadPre",
      dependencies = {
        -- "hrsh7th/cmp-nvim-lsp",
        -- "hrsh7th/nvim-cmp",
        "dnlhc/glance.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("plugins.lsp").configure()
      end,
    },

    -- NULL-LS
    {
      "jose-elias-alvarez/null-ls.nvim",
      event = "BufReadPre",
      dependencies = {
        -- "hrsh7th/cmp-nvim-lsp",
        "nvim-lua/plenary.nvim",
        "jay-babu/mason-null-ls.nvim",
      },
      config = function()
        require("plugins.nullls").configure()
      end,
    },

    -- Completion
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require("plugins.completion").configure()
      end,
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
        {
          "hrsh7th/nvim-insx",
          config = function()
            require("insx.preset.standard").setup()
          end,
        },
        {
          "L3MON4D3/LuaSnip",
          dependencies = {
            "rafamadriz/friendly-snippets",
            "honza/vim-snippets",
          },
          config = function()
            require("plugins.snippets").configure()
          end,
        },
      },
    },

    -- Task Runner
    {
      "kndndrj/nvim-projector",
      branch = "development",
      dir = require("secrets").get("projector_path"),
      keys = { "č" },
      dependencies = {
        "kndndrj/projector-loader-vscode",
        {
          "mfussenegger/nvim-dap",
          dependencies = {
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "jay-babu/mason-nvim-dap.nvim",
          },
          config = function()
            require("plugins.debug").configure()
          end,
        },
        {
          "kndndrj/nvim-dbee",
          dir = require("secrets").get("dbee_path"),
          dependencies = {
            "MunifTanjim/nui.nvim",
          },
          build = function()
            if not require("secrets").get("dbee_path") then
              require("dbee").install()
            end
          end,
          config = function()
            local dbee = require("dbee")

            dbee.setup {
              -- connections = require("secrets").get("dbee_connections"),
              sources = vim.list_extend(
                require("dbee.config").default.sources,
                { require("dbee.sources").MemorySource:new(require("secrets").get("dbee_connections")) }
              ),
              page_size = 500,
              lazy = true,
            }

            local map_options = { noremap = true, silent = true }
            vim.keymap.set("", "BL", function()
              dbee.next()
            end, map_options)
            vim.keymap.set("", "BH", function()
              dbee.prev()
            end, map_options)
          end,
        },
      },
      config = function()
        require("plugins.runner").configure()
      end,
    },

    -- Git
    {
      "tpope/vim-fugitive",
      cmd = { "G", "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
      dependencies = {
        "tpope/vim-rhubarb",
        "idanarye/vim-merginal",
      },
      config = function()
        require("plugins.git").configure_fugitive()
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("plugins.git").configure_gitsigns()
      end,
    },

    -- Database
    {
      "tpope/vim-dadbod",
      cmd = {
        "DBUIToggle",
        "DBUI",
        "DBUIAddConnection",
        "DBUIFindBuffer",
        "DBUIRenameBuffer",
        "DBUILastQueryInfo",
      },
      dependencies = {
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",
      },
      config = function()
        vim.g.db_ui_use_nerd_fonts = 1
      end,
    },

    -- LaTeX
    {
      "lervag/vimtex",
      ft = "tex",
      config = function()
        require("plugins.vimtex").configure()
      end,
    },

    -- Refactoring
    {
      "ThePrimeagen/refactoring.nvim",
      keys = { "<leader>rr" },
      dependencies = {
        -- "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("refactoring").setup {}

        vim.keymap.set("v", "<leader>rr", function()
          require("refactoring").select_refactor()
        end, { noremap = true, silent = true, expr = false })
      end,
    },
  }

  local opts = {}

  -- Bootstrap the plugin manager
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  end

  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup(plugins, opts)
end

return M
