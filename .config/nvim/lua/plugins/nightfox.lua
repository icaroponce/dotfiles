return {
  "EdenEast/nightfox.nvim",
  config = function()
    local nightfox = require "nightfox"

    nightfox.setup {
      options = {
        transparent = false,
        styles = {
          comments = "italic",
          functions = "italic",
          keywords = "bold",
        },
      },
    }

    vim.cmd "colorscheme nightfox"
  end,
}
