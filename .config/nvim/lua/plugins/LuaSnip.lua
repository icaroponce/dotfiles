return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  config = function()
    local ls = require "luasnip"
    local types = require "luasnip.util.types"
    ls.config.set_config {
      ext_opts = {
        [types.choiceNode] = {
          active = { virt_text = { { "choiceNode", "IncSearch" } } },
        },
        [types.insertNode] = { passive = { hl_group = "Substitute" } },
        [types.exitNode] = { passive = { hl_group = "Substitute" } },
      },
      updateevents = "TextChanged,TextChangedI",
      store_selection_keys = "<c-j>",
    }
  end,
}
