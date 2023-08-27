return {
  "tpope/vim-eunuch", -- vim sugar for UNIX shell cmds
  "tpope/vim-unimpaired", -- [ ] aliases
  "tpope/vim-fugitive", -- vim plugin for Git
  "tpope/vim-rhubarb",
  "tpope/vim-surround",
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    "sindrets/diffview.nvim",
    cmd = "DiffViewOpen",
  },

  { "plasticboy/vim-markdown", event = "VeryLazy", dependencies = { "godlygeek/tabular" } },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = [[require "nvim-autopairs".setup()]],
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    ft = { "css", "javascript", "vim", "html" },
    config = [[require "colorizer".setup {'css', 'javascript', 'vim', 'html'}]],
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = [[require "Comment".setup()]],
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
