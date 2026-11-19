-- nvim-treesitter `main` branch (needs Neovim 0.12+).
-- NixOS: home-manager sets vim.g.nix_treesitter to nvim-treesitter + prebuilt grammars from nixpkgs.
-- Elsewhere (Mac): from git; parsers are compiled on install (needs the tree-sitter CLI + a C compiler).
local nix_ts = vim.g.nix_treesitter

local parsers = {
  "c",
  "go",
  "lua",
  "haskell",
  "python",
  "nix",
  "vimdoc",
  "vim",
  "graphql",
  "javascript",
  "typescript",
  "json",
  "elm",
  "terraform",
  "elixir",
}

local function textobjects_keymaps()
  require("nvim-treesitter-textobjects").setup { move = { set_jumps = true } }

  local move = require "nvim-treesitter-textobjects.move"
  local keys = {
    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
  }
  for fn, maps in pairs(keys) do
    for lhs, query in pairs(maps) do
      vim.keymap.set({ "n", "x", "o" }, lhs, function()
        move[fn](query, "textobjects")
      end)
    end
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dir = nix_ts,
    build = not nix_ts and ":TSUpdate" or nil,
    lazy = false, -- main does not support lazy-loading
    config = function()
      if not nix_ts then
        require("nvim-treesitter").install(parsers)
      end

      -- Highlighting (Neovim) and indent (nvim-treesitter) for every filetype that has a parser.
      local no_indent = { c = true, python = true }
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserTreesitter", {}),
        callback = function(ev)
          if not pcall(vim.treesitter.start, ev.buf) then
            return
          end
          if not no_indent[vim.bo[ev.buf].filetype] then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- Incremental selection: what Neovim 0.12's built-in visual `an`/`in` do (mini.ai takes
      -- those keys). vim.treesitter._select is internal, so fall back to LSP selection ranges.
      local function select_node(fn, lsp_dir)
        return function()
          local ok = vim.treesitter.get_parser(nil, nil, { error = false })
            and pcall(function()
              require("vim.treesitter._select")[fn](vim.v.count1)
            end)
          if not ok then
            vim.lsp.buf.selection_range(lsp_dir * vim.v.count1)
          end
        end
      end
      vim.keymap.set("n", "<c-space>", "v<c-space>", { remap = true, desc = "Select treesitter node" })
      vim.keymap.set("x", "<c-space>", select_node("select_parent", 1), { desc = "Expand to parent node" })
      vim.keymap.set("x", "<c-backspace>", select_node("select_child", -1), { desc = "Shrink to child node" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    config = textobjects_keymaps,
  },
}
