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
        "nvim-telescope/telescope-file-browser.nvim",
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
      "kndndrj/nvim-barn",
      dir = secrets.get("nav_path"),
      dependencies = {
        "Iron-E/nvim-libmodal",
      },
      config = function()
        require("barn").setup {
          resize = {
            resize_step_x = 4,
            resize_step_y = 4,
          },
          mappings = {
            -- layer_timeout_ms = 800,
            prefix_key = "<C-s>",
          },
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
            {
              "rcarriga/nvim-dap-ui",
              dependencies = { "nvim-neotest/nvim-nio" },
            },
            "mfussenegger/nvim-dap-python",
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
            require("plugins.dbee").configure(secrets.get("dbee_connections"))
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
      "SuperBo/fugit2.nvim",
      opts = {
        width = 70,
        external_diffview = true, -- tell fugit2 to use diffview.nvim instead of builtin implementation.
      },
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
      },
      cmd = { "Fugit2", "Fugit2Diff", "Fugit2Graph" },
    },
    {
      "sindrets/diffview.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      -- lazy, only load diffview by these commands
      cmd = {
        "DiffviewFileHistory",
        "DiffviewOpen",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
      },
    },
    {
      "FabijanZulj/blame.nvim",
      config = function()
        require("blame").setup {
          mappings = {
            commit_info = "K",
          },
        }
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
