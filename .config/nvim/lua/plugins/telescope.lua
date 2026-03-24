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
    { "<C-p>",      "<cmd>Telescope find_files<cr>",          desc = "Telescope: Find Files" },
    { "<leader>fF", function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = true,
          file_ignore_patterns = { 'node_modules/', '%.git/', 'dist/', 'tmp/', 'logs/', '%.cache/' },
        })
      end, desc = "Telescope: Find Files (no gitignore)" },
    { "<C-/>",      "<cmd>Telescope live_grep<cr>",           desc = "Telescope: Live Grep" },
    { "<leader>'",  "<cmd>Telescope buffers<cr>",             desc = "Telescope: Buffers" },
    { "<leader>ft", "<cmd>Telescope help_tags<cr>",           desc = "Telescope: Help Tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",            desc = "Telescope: Recent Files" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>",          desc = "Telescope: Git Status" },
    { "<leader>gr", "<cmd>Telescope lsp_references<cr>",      desc = "Telescope: LSP References" },
    { "<leader>km", "<cmd>Telescope keymaps<cr>",             desc = "Telescope: Keymaps" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Telescope: Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>",         desc = "Telescope: Workspace Diagnostics" },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>",         desc = "Telescope: Grep String" },
    { "<leader>:",  "<cmd>Telescope command_history<cr>",     desc = "Telescope: Command History" },
  },
  config = function()
    local map = vim.keymap.set
    local telescope = require "telescope"
    local telescope_actions = require "telescope.actions"
    local telescope_builtin = require "telescope.builtin"
    local telescope_themes = require "telescope.themes"

    telescope.setup {
      pickers = {
        live_grep = {
          file_ignore_patterns = { 'node_modules', '.git'},
          additional_args = function(_)
            return { "--hidden" }
          end
        },
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git' },
          hidden = true,
        }
      },
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.9,
            height = 0.9,
            preview_height = 0.5,
            preview_cutoff = 20,
          }
        },
        mappings = {
          i = {
            ["<C-j>"] = telescope_actions.move_selection_next,
            ["<C-k>"] = telescope_actions.move_selection_previous,
            ["<C-l>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,
            ["<C-d>"] = telescope_actions.preview_scrolling_up,
            ["<C-b>"] = telescope_actions.preview_scrolling_down,
          },
        },
      },
      extensions = {
        "fzf",
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
