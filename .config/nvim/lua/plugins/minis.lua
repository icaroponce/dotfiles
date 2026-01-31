return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      for _, mini in ipairs {
        -- "bracketed",
        "pairs",
        "surround",
        "align",
        "icons",
        "jump",
      } do
        require(("mini.%s"):format(mini)).setup {}
      end

      local ai = require "mini.ai"
      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
      -- require("mini.icons").mock_nvim_web_devicons()

      local move = require "mini.move"
      move.setup {
        mappings = {
          -- Move visual selection in Visual mode.
          down = "∆",
          up = "˚",
          -- Move current line in Normal mode
          line_down = "∆",
          line_up = "˚",
        },
      }

    end,
  },
}
