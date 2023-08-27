return {
  "L3MON4D3/LuaSnip",
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

    --   vim.cmd [[
    --             imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'
    --             imap <silent><expr> <c-k>  luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev': '<c-k>'
    --             imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice': '<c-e>'
    --             snoremap <silent> <c-j> <cmd>lua require'luasnip'.jump(1)<Cr>
    --             snoremap <silent> <c-k> <cmd>lua require'luasnip'.jump(-1)<Cr>
    --             vnoremap <c-f>  \"ec<cmd>lua require('luasnip.extras.otf').on_the_fly()<cr>
    --             inoremap <c-f>  <cmd>lua require('luasnip.extras.otf').on_the_fly('e')<cr>
    --         ]]
  end,
}
