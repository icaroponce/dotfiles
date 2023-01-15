local map = vim.keymap.set
local telescope = require "telescope"
local telescope_actions = require "telescope.actions"
local telescope_builtin = require "telescope.builtin"
local telescope_themes = require "telescope.themes"

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
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

telescope.load_extension "ui-select"

map("n", "<C-p>", telescope_builtin.find_files, { desc = "Find Files" })
map("n", "<C-/>", telescope_builtin.live_grep, { desc = "Find by Grep" })
map("n", "<leader>'", telescope_builtin.buffers, { desc = "['] Find existing buffers" })
map("n", "<leader>ft", telescope_builtin.help_tags, { desc = "Search help tags" })
map("n", "<leader>gs", telescope_builtin.git_status, { desc = "Show [G]it [S]tatus" })
map("n", "<leader>gr", telescope_builtin.lsp_references, { desc = "Find LSP refences" })
map("n", "<leader>km", telescope_builtin.keymaps, { desc = "Find [K]ey[M]aps" })
map("n", "<leader>?", telescope_builtin.oldfiles, { desc = "[?] Find recently opened files" })
map("n", "<leader>/", function()
  telescope_builtin.current_buffer_fuzzy_find(telescope_themes.get_dropdown {
    winblend = 15,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer]" })

map("n", "<leader>sd", telescope_builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sw", telescope_builtin.grep_string, { desc = "[S]earch current [W]ord" })
