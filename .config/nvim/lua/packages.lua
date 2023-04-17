local packer = require "packer"

packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "tpope/vim-eunuch" -- vim sugar for UNIX shell cmds
  use "tpope/vim-unimpaired" -- [ ] aliases
  use "tpope/vim-fugitive" -- vim plugin for Git
  use "tpope/vim-rhubarb"
  use "tpope/vim-surround"
  use "sheerun/vim-polyglot"

  use {
    "nvim-treesitter/nvim-treesitter",
    config = [[require "plugins.nvim-treesitter"]],
    run = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
  }
  use { -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  }
  -- use {
  --   "ray-x/lsp_signature.nvim",
  --   config = [[require "lsp_signature".setup({ floating_window = true })]],
  -- }
  use {
    "neovim/nvim-lspconfig",
    requires = {
      -- Additional lua configuration, makes nvim stuff amazing
      use "folke/neodev.nvim",

      -- Useful status updates for LSP
      use "j-hui/fidget.nvim",
    },
    config = [[require "plugins.nvim-lspconfig"]],
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "rafamadriz/friendly-snippets"
    },
    config = [[require "plugins.nvim-cmp"]],
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = [[require "plugins.telescope"]],
  }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable "make" == 1 }
  use {
    "neovimhaskell/haskell-vim",
    config = [[require "plugins.haskell"]],
  }
  use {
    "hoob3rt/lualine.nvim",
    config = [[require("plugins.lualine")]],
  }
  -- use "machakann/vim-highlightedyank"
  use "justinmk/vim-dirvish"
  use {
    "windwp/nvim-autopairs",
    config = [[require "nvim-autopairs".setup()]],
  }

  use "lukas-reineke/indent-blankline.nvim"
  use {
    "EdenEast/nightfox.nvim",
    config = [[require "plugins.nightfox"]],
  }
  use {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "javascript", "vim", "html" },
    config = [[require "colorizer".setup {'css', 'javascript', 'vim', 'html'}]],
  }
  use { "plasticboy/vim-markdown", requires = { "godlygeek/tabular" } }
  use {
    "numToStr/Comment.nvim",
    config = [[require "Comment".setup()]],
  }

  use {
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = [[require "plugins.gitsigns"]],
  }

  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = [[require "plugins.tree"]],
  }

  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons',
    config = [[require "bufferline".setup()]] }

  use {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({})
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  }
end)
