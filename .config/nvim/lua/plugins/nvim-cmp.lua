local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"
local types = require "luasnip.util.types"

luasnip.config.set_config {
  updateevents = "TextChanged,TextChangedI",
  store_selection_keys = "<c-j>",
  ext_opts = {
    [types.insertNode] = {
      passive = {
        hl_group = "Substitute",
      },
    },
    [types.choiceNode] = {
      active = {
        virt_text = { { "choiceNode", "IncSearch" } },
      },
    },
  },
}

vim.cmd [[
  imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'
  imap <silent><expr> <c-k>  luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev': '<c-k>'
  imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice': '<c-e>'
  snoremap <silent> <c-j> <cmd>lua require'luasnip'.jump(1)<Cr>
  snoremap <silent> <c-k> <cmd>lua require'luasnip'.jump(-1)<Cr>
  vnoremap <c-f>  "ec<cmd>lua require('luasnip.extras.otf').on_the_fly()<cr>
  inoremap <c-f>  <cmd>lua require('luasnip.extras.otf').on_the_fly('e')<cr>
]]

cmp.setup {
  -- compe.preselect = 'always' equivalent
  -- completion = {
  --    completeopt = 'menu,menuone,noinsert',
  --  },
  formatting = {
    format = lspkind.cmp_format { with_text = true, maxwidth = 50 },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
        -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
        -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end,
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
    { name = "path" },
    -- { name = "buffer" },
  },
}
