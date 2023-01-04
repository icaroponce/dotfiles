local keymap = vim.keymap
local telescope = require "telescope"
local telescope_actions = require "telescope.actions"
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = telescope_actions.move_selection_next,
        ["<C-k>"] = telescope_actions.move_selection_previous,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

require("telescope").load_extension "ui-select"

keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>'", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>")
keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>")
