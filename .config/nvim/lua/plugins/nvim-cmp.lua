return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
  },
  config = function()
    local cmp = require "cmp"
    local lspkind = require "lspkind"
    -- local types = require "luasnip.util.types"

    local function expand_snippet(args)
      return require("luasnip").lsp_expand(args.body)
    end

    -- luasnip.config.set_config {
    --   updateevents = "TextChanged,TextChangedI",
    --   store_selection_keys = "<c-j>",
    --   ext_opts = {
    --     [types.insertNode] = {
    --       passive = {
    --         hl_group = "Substitute",
    --       },
    --     },
    --     [types.exitNode] = { passive = { hl_group = "Substitute" } },
    --     [types.choiceNode] = {
    --       active = {
    --         virt_text = { { "choiceNode", "IncSearch" } },
    --       },
    --     },
    --   },
    -- }

    --     vim.cmd [[
    --   imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'
    --   imap <silent><expr> <c-k>  luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev': '<c-k>'
    --   imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice': '<c-e>'
    --   snoremap <silent> <c-j> <cmd>lua require'luasnip'.jump(1)<Cr>
    --   snoremap <silent> <c-k> <cmd>lua require'luasnip'.jump(-1)<Cr>
    --   vnoremap <c-f>  "ec<cmd>lua require('luasnip.extras.otf').on_the_fly()<cr>
    --   inoremap <c-f>  <cmd>lua require('luasnip.extras.otf').on_the_fly('e')<cr>
    -- ]]

    cmp.setup {
      formatting = {
        format = lspkind.cmp_format { with_text = true, maxwidth = 50 },
      },
      snippet = { expand = expand_snippet },
      experimental = { ghost_text = { hl_group = "Comment" } },
      mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "calc" },
        { name = "emoji" },
        { name = "buffer" },
        { name = "path" },
      },
    }
  end,
}
