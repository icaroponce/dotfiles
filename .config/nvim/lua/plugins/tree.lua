return {
  "kyazdani42/nvim-tree.lua",
  dependencies = "kyazdani42/nvim-web-devicons",
  keys = {
    {
      "<leader>tt",
      function()
        require("nvim-tree.api").tree.toggle()
      end,
    },
  },
  config = function()
    local tree = require "nvim-tree"
    tree.setup {
      hijack_cursor = true,
      update_focused_file = {
        enable = true,
      },
      view = {
        width = {
          min = 30,
          max = -1,
        },
      },
    }
  end,
}
