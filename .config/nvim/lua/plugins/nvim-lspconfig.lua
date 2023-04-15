local lsp = require "lspconfig"

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
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

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("neodev").setup()

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
            diff = true
          }
        }
      }
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
    on_attach = on_attach,
  }
end

require("fidget").setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  signs = true,
  virtual_text = false,
})

vim.cmd [[
    sign define DiagnosticSignError text=🔻 linehl= numhl=
    sign define DiagnosticSignWarn text=🔸 linehl= numhl=
    sign define DiagnosticSignInfo text=🔹 linehl= numhl=
    sign define DiagnosticSignHint text=👉 linehl= numhl=
]]
