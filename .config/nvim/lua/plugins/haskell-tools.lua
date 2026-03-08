return {
  "mrcjkb/haskell-tools.nvim",
  version = "^7",
  lazy = false,
  config = function()
    vim.g.haskell_tools = {
      hls = {
        settings = {
          haskell = {
            formattingProvider = "fourmolu",
            plugin = {
              rename = {
                config = { diff = true },
              },
            },
          },
        },
      },
    }
  end,
}
