return {
  "lewis6991/gitsigns.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local map = vim.keymap.set

    require("gitsigns").setup {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = require "gitsigns"

        local function create_navigation_map(mapping, go_fn)
          local mode = "n"
          local function navigate()
            if vim.wo.diff then
              return mapping
            end
            vim.schedule(function()
              go_fn()
            end)
            return "<Ignore>"
          end

          map(mode, mapping, navigate, { expr = true, buffer = bufnr })
        end

        map("n", "<leader>h", gs.preview_hunk)
        map("n", "<leader>b", gs.toggle_current_line_blame)
        create_navigation_map("]c", gs.next_hunk)
        create_navigation_map("[c", gs.prev_hunk)
      end,
    }
  end,
}
