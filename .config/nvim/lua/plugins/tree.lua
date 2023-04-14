local tree = require "nvim-tree"
tree.setup {
  hijack_cursor = true,
  update_focused_file = {
    enable = true,
  },
}

vim.keymap.set("n", "<leader>t", require("nvim-tree.api").tree.toggle)

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "NvimTree*",
  callback = function()
    vim.opt.cursorline = true
  end,
})
