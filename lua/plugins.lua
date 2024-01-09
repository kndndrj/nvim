local secrets = require("secrets")
-------------------------
-- Plugins: -------------
-------------------------
local M = {}

function M.configure()
  local plugins = {
    { "folke/lazy.nvim" },

    -- Pretty
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
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
        require("plugins.statusline").configure_lualine()
      end,
    },
    {
      "akinsho/bufferline.nvim",
      dependencies = {
        -- "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("plugins.statusline").configure_bufferline()
      end,
    },
    {
      "j-hui/fidget.nvim",
      event = "LspAttach",
      config = function()
        require("fidget").setup {
          notification = {
            window = {
              winblend = 0,
            },
          },
        }
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
        require("ibl").setup {
          exclude = {
            buftypes = {
              "terminal",
            },
            filetypes = {
              "help",
              "terminal",
            },
          },
          indent = {
            char = "│",
          },
        }
      end,
    },
    {
      "nmac427/guess-indent.nvim",
      event = "BufReadPre",
      config = function()
        require("guess-indent").setup {}
      end,
    },
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    },
    {
      "NvChad/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
        require("colorizer").setup {}
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
        { "ii14/emmylua-nvim", ft = "lua" },
      },
      config = function()
        -- default lsp config
        require("plugins.lsp").configure()
      end,
    },

    -- Linters
    {
      "mfussenegger/nvim-lint",
      dependencies = {
        "rshkarin/mason-nvim-lint",
      },
      config = function()
        require("plugins.lint").configure()
      end,
    },

    -- Formatters
    {
      "stevearc/conform.nvim",
      config = function()
        require("plugins.format").configure()
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
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
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
      dir = secrets.get("projector_path"),
      keys = { "č" },
      dependencies = {
        {
          "kndndrj/projector-neotest",
          dir = secrets.get("projector_neotest_path"),
        },
        {
          "nvim-neotest/neotest",
          dependencies = {
            -- "nvim-lua/plenary.nvim",
            -- "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",

            "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-python",
            "rouge8/neotest-rust",
          },
          config = function()
            -- get neotest namespace (api call creates or returns namespace)
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
              virtual_text = {
                format = function(diagnostic)
                  local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                  return message
                end,
              },
            }, neotest_ns)
            require("neotest").setup {
              adapters = {
                require("neotest-go"),
                require("neotest-python"),
                require("neotest-rust"),
              },
            }
          end,
        },
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
          "kndndrj/projector-dbee",
          dir = secrets.get("projector_dbee_path"),
        },
        {
          "kndndrj/nvim-dbee",
          dir = secrets.get("dbee_path"),
          dependencies = {
            "MunifTanjim/nui.nvim",
          },
          build = function()
            if not secrets.get("dbee_path") then
              require("dbee").install()
            end
          end,
          config = function()
            require("dbee").setup {
              sources = vim.list_extend(
                require("dbee.config").default.sources,
                { require("dbee.sources").MemorySource:new(secrets.get("dbee_connections")) }
              ),
              drawer = {
                disable_help = true,
              },
            }
          end,
        },
      },
      config = function()
        require("plugins.runner").configure()
      end,
    },

    -- Git
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
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        -- "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("neogit").setup()
      end,
    },

    -- AI
    {
      "jackMort/ChatGPT.nvim",
      event = "VeryLazy",
      config = function()
        local token = secrets.get("chatgpt_token")
        if token and not vim.env.OPENAI_API_KEY then
          vim.env.OPENAI_API_KEY = token
        end
        require("chatgpt").setup {
          show_quickfixes_cmd = "copen",
        }
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },
    {
      "Exafunction/codeium.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("codeium").setup()
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
