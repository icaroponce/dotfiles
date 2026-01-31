return {
  "tpope/vim-fugitive", -- vim plugin for Git
  "tpope/vim-rhubarb",
  {
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

          local function create_navigation_map(mapping, go_fn, opts)
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

            map(mode, mapping, navigate, { expr = true, buffer = bufnr, desc = opts.desc })
          end

          map({ "n", "v" }, "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
          map({ "n", "v" }, "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Buffer" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line { full = true }
          end, { desc = "Blame Line" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Blame Line" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>hD", function()
            gs.diffthis "~"
          end, { desc = "Diff this ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })
          map("n", "<leader>h", gs.preview_hunk, { desc = "Preview [H]unk" })
          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

          create_navigation_map("]c", gs.next_hunk, { desc = "next hunk" })
          create_navigation_map("[c", gs.prev_hunk, { desc = "previous hunk" })
        end,
      }
    end,
  },
}
