return {
  "tpope/vim-eunuch", -- vim sugar for UNIX shell cmds
  "tpope/vim-unimpaired", -- bracketed mappigs ]q ]p...
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    "sindrets/diffview.nvim",
    cmd = "DiffViewOpen",
  },
  -- { "plasticboy/vim-markdown", event = "VeryLazy", dependencies = { "godlygeek/tabular" } },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    ft = { "css", "javascript", "vim", "html" },
    config = [[require "colorizer".setup {'css', 'javascript', 'vim', 'html'}]],
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  { "akinsho/toggleterm.nvim", version = "*", opts = {
    open_mapping = [[<c-\>]],
  } },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
}
