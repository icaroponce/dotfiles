local ts = require "nvim-treesitter.configs"
ts.setup {
  ensure_installed = "all",
  highlight = { enable = true },
  -- indent = {enable = true}
  run = ":TSUpdate",
}
