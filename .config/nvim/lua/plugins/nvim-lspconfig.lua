local lsp = require "lspconfig"
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  local buf_map = vim.api.nvim_buf_set_keymap

  buf_map(bufnr, "n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_map(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_map(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_map(bufnr, "n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_map(bufnr, "n", "gi", "<cmd>lua lsp_organize_imports()<CR>", opts)
  buf_map(bufnr, "n", "[k", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_map(bufnr, "n", "]k", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_map(bufnr, "n", "<Leader>a", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_map(bufnr, "i", "<C-x><C-x>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
end

lsp.sumneko_lua.setup { on_attach = on_attach, capabilities = capabilities }
lsp.pylsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lsp.tsserver.setup {
  capabilities = capabilities,
  root_dir = function()
    return vim.loop.cwd()
  end,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false -- avoid conflicts with eslint formatting
    on_attach(client, bufnr)
  end,
}
lsp.eslint.setup {
  settings = {
    format = true,
  },
  root_dir = function()
    return vim.loop.cwd()
  end,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    on_attach(client, bufnr)
    vim.cmd [[autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx lua vim.lsp.buf.formatting_seq_sync(nil, 1000)]]
  end,
}
lsp.hls.setup {
  on_attach = on_attach,
  settings = {
    haskell = {
      formattingProvider = "fourmolu",
    },
  },
}

require("rust-tools").setup {}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    signs = true,
    virtual_text = false,
  }
)

vim.cmd [[
    sign define DiagnosticSignError text=🔻 linehl= numhl=
    sign define DiagnosticSignWarn text=🔸 linehl= numhl=
    sign define DiagnosticSignInfo text=🔹 linehl= numhl=
    sign define DiagnosticSignHint text=👉 linehl= numhl=
]]
