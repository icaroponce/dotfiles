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
