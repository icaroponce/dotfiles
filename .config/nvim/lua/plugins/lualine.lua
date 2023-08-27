return {
  "hoob3rt/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require "lualine"
    lualine.setup {
      options = {
        theme = "nightfox",
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
        extensions = { "quickfix" },
      },
    }
  end,
}
