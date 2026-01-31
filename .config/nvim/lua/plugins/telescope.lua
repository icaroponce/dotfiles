return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable "make" == 1 },
  },
  cmd = "Telescope",
  keys = {
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fh", "<cmd>Telescope find_files hidden=true<cr>", desc = "[F]ind Files (with [H]idden)" },
    { "<C-/>", "<cmd>Telescope live_grep<cr>", desc = "Find by Grep" },
    { "<leader>'", "<cmd>Telescope buffers<cr>", desc = "['] Find existing buffers" },
    { "<leader>ft", "<cmd>Telescope help_tags<cr>", desc = "Search help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[?] Find recently opened files" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Show [G]it [S]tatus" },
    { "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "Find LSP refences" },
    { "<leader>km", "<cmd>Telescope keymaps<cr>", desc = "Find [K]ey[M]aps" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "[S]earch current [W]ord" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command history" },
  },
  config = function()
    local map = vim.keymap.set
    local telescope = require "telescope"
    local telescope_actions = require "telescope.actions"
    local telescope_builtin = require "telescope.builtin"
    local telescope_themes = require "telescope.themes"

    telescope.setup {
      defaults = {
        layout_config = {
          horizontal = {
            width = 0.8
          }
        },
        mappings = {
          i = {
            ["<C-j>"] = telescope_actions.move_selection_next,
            ["<C-k>"] = telescope_actions.move_selection_previous,
            ["<C-l>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {},
        },
      },
    }
    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")

    telescope.load_extension "ui-select"

    map("n", "<leader>/", function()
      telescope_builtin.current_buffer_fuzzy_find(telescope_themes.get_dropdown {
        winblend = 15,
        previewer = false,
      })
    end, { desc = "[/] Fuzzily search in current buffer]" })
  end,
}
