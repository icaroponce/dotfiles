return {
  "tpope/vim-eunuch", -- vim sugar for UNIX shell cmds
  "tpope/vim-unimpaired", -- bracketed mappigs ]q ]p...
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<cr>",            desc = "Diffview: Open" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>",           desc = "Diffview: Close" },
      { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>",   desc = "Diffview: File History" },
      { "<leader>dM", function()
          local branch = vim.fn.system("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null")
            :gsub("refs/remotes/origin/", "")
            :gsub("\n", "")
          if branch == "" then branch = "main" end
          vim.cmd("DiffviewOpen " .. branch)
        end, desc = "Diffview: Open vs Main" },
    },
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
      vim.g.mkdp_preview_options = { maid = {} }
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
  opts = {},
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
