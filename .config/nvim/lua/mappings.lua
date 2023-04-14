local map = vim.keymap.set

-- better navigation between panes
map({ "n", "t" }, "<leader>w", ":split<CR>")
map({ "n", "t" }, "<leader>v", ":vsplit<CR>")
map({ "n", "t", "i" }, "<C-h>", "<C-\\><C-N><C-w>h<CR>")
map({ "n", "t", "i" }, "<C-t>", "<C-\\><C-N><C-w>j<CR>")
map({ "n", "t", "i" }, "<C-n>", "<C-\\><C-N><C-w>k<CR>")
map({ "n", "t", "i" }, "<C-s>", "<C-\\><C-N><C-w>l<CR>")
map({ "n", "t", "i" }, "<C-A-h>", "5<C-w><<CR>")
map({ "n", "t", "i" }, "<C-A-t>", "5<C-w>-<CR>")
map({ "n", "t", "i" }, "<C-A-n>", "5<C-w>+<CR>")
map({ "n", "t", "i" }, "<C-A-s>", "5<C-w>><CR>")

-- easier map to ":"
map("n", "<Space>", ":", { silent = false })
map("x", "<Space>", ":", { silent = false })

map("n", "<C-l>", "<cmd>noh<CR>") -- Clear highlights
map("n", "<C-,>", "^")
map("n", "<C-.>", "$")

vim.cmd [[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall
]]

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 300 }
  end,
  group = highlight_group,
  pattern = "*",
})
