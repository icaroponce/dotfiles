return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require "conform"
      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          json = { "jq" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          markdown = { "prettier" },
          yaml = { "prettier" },
        },
        -- format_on_save = {
        --   timeout_ms = 500,
        --   lsp_format = "fallback",
        --   async = false,
        --   quiet = false,
        -- },
      }

      vim.keymap.set({ "n", "v" }, "<leader>=", function()
        conform.format { lsp_fallback = "always", async = true }
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        yaml = { "yamllint" },
        lua = { "luacheck" },
        -- js = { "eslint" },
        -- ts = { "eslint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Additional lua configuration, makes nvim stuff amazing
      "folke/neodev.nvim",

      -- Useful status updates for LSP
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
      },
      "saghen/blink.cmp"
    },
    config = function()
      require("neodev").setup()
      require("fidget").setup()

      local function toggle_inlay()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end

      local mappings = {
        ["<Leader>lq"] = vim.diagnostic.setloclist,
        ["<Leader>li"] = toggle_inlay,
      }

      for shortcut, callback in pairs(mappings) do
        vim.keymap.set("n", shortcut, callback, { noremap = true, silent = true })
      end

      local on_attach = function(buff)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = buff, desc = desc })
        end

        nmap("ca", vim.lsp.buf.code_action)
        nmap("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
        nmap("gr", vim.lsp.buf.rename)
        nmap("ga", vim.lsp.buf.format)
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("[k", vim.diagnostic.goto_prev)
        nmap("]k", vim.diagnostic.goto_next)
        nmap("<Leader>a", vim.diagnostic.open_float)
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("<leader>gr", require("telescope.builtin").lsp_references, "[G]o to LSP [R]eferences")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>fa", vim.lsp.buf.format, "Formatting")

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(buff, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          on_attach(ev.buf)
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function lsp_enable(name, conf)
        local config = conf or {}
        config.capabilities = capabilities

        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end

      local servers = {
        pylsp = {},
        eslint = {},
        ts_ls = {},
        elmls = {},
        hls = {
          haskell = {
            formattingProvider = "fourmolu",
            plugin = {
              rename = {
                config = {
                  diff = true,
                },
              },
            },
          },
        },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        terraformls = {},
      }

      for server, settings in pairs(servers) do
        lsp_enable(server, settings)
      end

      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "⚬",
            [vim.diagnostic.severity.WARN] = "⚬",
            [vim.diagnostic.severity.INFO] = "⚬",
            [vim.diagnostic.severity.HINT] = "⚬",
          },
        },
      }
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup {
        profile = "powerline",
      }
      vim.diagnostic.config { virtual_text = false }  -- Disable Neovim's default virtual text diagnostics
    end,
  },
}
