local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

-- require("which-key").add({
--   { "<leader>r", group = "repl",   buffer = bufnr },
--   { "<leader>h", group = "hoogle", buffer = bufnr },
-- })

local function map(key, action, desc)
  vim.keymap.set("n", key, action, vim.tbl_extend("force", opts, { desc = desc }))
end

-- Repl
map("<leader>rr", ht.repl.toggle,                                                "Haskell: toggle repl (package)")
map("<leader>rb", function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end,  "Haskell: toggle repl (buffer)")
map("<leader>rq", ht.repl.quit,                                                  "Haskell: quit repl")

-- Hoogle
map("<leader>hs", ht.hoogle.hoogle_signature,                                    "Haskell: Hoogle search signature")

-- Code lenses & eval
map("<leader>cl", vim.lsp.codelens.run,                                          "Haskell: run code lens")
map("<leader>ea", ht.lsp.buf_eval_all,                                           "Haskell: evaluate all snippets")
