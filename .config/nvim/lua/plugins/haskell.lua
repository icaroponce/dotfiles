return {
  "neovimhaskell/haskell-vim",
  event = "VeryLazy",
  config = function()
    vim.g.haskell_classic_highlighting = 1
    vim.g.haskell_indent_do = 4
    vim.g.haskell_indent_case = 4
    vim.g.haskell_indent_if = 4
    vim.g.haskell_indent_in = 4
    vim.g.haskell_indent_guard = 4
    vim.g.haskell_indent_before_where = 2
    vim.g.haskell_indent_after_bare_where = 2
    vim.g.haskell_indent_case_alternative = 4
  end,
}
