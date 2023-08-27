return {
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
    },
    config = function()
      require("neodev").setup()
      require("fidget").setup()

      local lsp = require "lspconfig"

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

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = {
        pylsp = {},
        eslint = {},
        tsserver = {},
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
      }

      for server, settings in pairs(servers) do
        lsp[server].setup {
          capabilities = capabilities,
          settings = settings,
        }
      end

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        signs = true,
        virtual_text = false,
      })

      for name, text in pairs {
        Error = "🔻",
        Warn = "🔶",
        Info = "🔷",
        Hint = "👉",
      } do
        vim.fn.sign_define("DiagnosticSign" .. name, { text = text, linehl = "", numhl = "" })
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    enabled = true,
    opts = function()
      local nls = require "null-ls"
      return {
        sources = {
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.ruff,
          nls.builtins.formatting.ruff,
          -- nls.builtins.formatting.black,
          nls.builtins.formatting.alejandra,
          nls.builtins.formatting.jq,
        },
      }
    end,
  },
}
