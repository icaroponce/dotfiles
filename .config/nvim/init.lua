local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd 'packadd packer.nvim' -- load the package manager
end

cmd "syntax enable"

opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

opt.backspace = {'indent', 'eol', 'start'}
opt.pumheight = 20
opt.completeopt = {'menuone', 'noselect'} -- Completion options
-- opt.wildmode = {'list', 'longest'} -- Command-line completion mode

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- smart case when searching
opt.hlsearch = true -- highlight same words when searching
opt.incsearch = true -- updates the searching match hl while typing
opt.hidden = true -- hides mouse pointer when typing
opt.showmatch = true -- show matching brackets
-- opt.matchtime = 2

-- disable errors beeps
opt.errorbells = false
opt.visualbell = false

-- more natural split
opt.splitbelow = true
opt.splitright = true

opt.cursorline = false
opt.autoread = true -- auto read file changes
opt.grepprg = "rg --vimgrep --no-heading --smart-case"

-- default tab 4 spaces
opt.shiftwidth = 4
opt.softtabstop = 4

opt.encoding = "utf-8"
opt.history = 5000
opt.swapfile = false
opt.signcolumn = "yes"
opt.ruler = true 
opt.expandtab = true
opt.wrap = false
opt.termguicolors = true
opt.showmode = false -- get rido fo the -- INSERT --
opt.clipboard = 'unnamedplus'
opt.wrap = false -- disable wrap line
cmd "set shortmess+=c"

local packer = require('packer')

packer.startup(function()
  -- Packer can manage itself --
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-eunuch' -- vim sugar for UNIX shell cmds
    use 'tpope/vim-unimpaired' -- [ ] aliases
    use 'tpope/vim-fugitive' -- vim plugin for Git
    use 'tpope/vim-rhubarb'
    use 'sheerun/vim-polyglot'

    use 'hrsh7th/nvim-compe'
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'junegunn/fzf.vim'
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
    use 'hoob3rt/lualine.nvim'
    use 'ojroques/nvim-lspfuzzy'
    use 'ryanoasis/vim-devicons'
    use 'machakann/vim-highlightedyank'
    use 'justinmk/vim-dirvish'
    use 'windwp/nvim-autopairs'

    use 'morhetz/gruvbox'
    use 'terryma/vim-expand-region'
    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = 'lua'
    }

    use 'ap/vim-css-color' -- highlight hex and rgb colors
    use {'plasticboy/vim-markdown', requires = {'godlygeek/tabular'}}

    use 'tpope/vim-commentary'
    use { 
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }
end)

cmd 'colorscheme gruvbox'
g['gruvbox_italic'] = 1
g['gruvbox_contrast_dark'] = 'medium'

local lualine = require 'lualine'
lualine.setup({
        options ={
            theme = 'gruvbox',
            icons_enabled = false,
            section_separators = '',
            component_separators = '',
            extensions = {'quickfix'}
        }
    })

g['mapleader'] = ','
g['deoplete#enable_at_startup'] = 1  -- enable deoplete at startup

g['python3_host_prog'] = '~/.pyenv/versions/neovim3/bin/python'
g['python_host_prog'] = '~/.pyenv/versions/neovim2/bin/python'

-- gitsigns --
local gitsigns = require 'gitsigns'
gitsigns.setup {}


-- tree-sitter configuration --
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-- nvim-autopairs --
local ap = require 'nvim-autopairs'
ap.setup()

-- lsp configuration --
local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'
local compe = require 'compe'

compe.setup {
    enabled = true;
    autocomplete = true;
    debug = true;
    min_length = 1;
    preselect = 'always';
    throttle_time = 80;
    source_timeout = 200;
    resolve_timeout = 800;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        ultisnips = true;
    };
}


cmd "inoremap <silent><expr> <CR>      compe#confirm('<CR>')"
cmd "inoremap <silent><expr> <C-Space> compe#complete()"
-- cmd "inoremap <silent><expr> <C-e>     compe#close('<C-e>')"
-- cmd "inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })"
-- cmd "inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })"

-- root_dir is where the LSP server will start: here at the project root otherwise in current folder
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--lsp.pyls.setup {root_dir = lsp.util.root_pattern('.git', fn.getcwd()), capabilities=capabilities}
lsp.pyls.setup { capabilities = capabilities }

local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

vim.lsp.handlers["textDocument/formatting"] = format_async

_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap
    cmd("command! LspDef lua vim.lsp.buf.definition()")
    cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    cmd("command! LspHover lua vim.lsp.buf.hover()")
    cmd("command! LspRename lua vim.lsp.buf.rename()")
    cmd("command! LspOrganize lua lsp_organize_imports()")
    cmd("command! LspRefs lua vim.lsp.buf.references()")
    cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    cmd(
        "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
    buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
    buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
    buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
    buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
    buf_map(bufnr, "n", "[k", ":LspDiagPrev<CR>", {silent = true})
    buf_map(bufnr, "n", "]k", ":LspDiagNext<CR>", {silent = true})
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
        {silent = true})

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
            augroup LspAutocommands
            autocmd! * <buffer>
            autocmd BufWritePost <buffer> LspFormatting
            augroup END
            ]], true)
    end
end
-- <Tab> to navigate the completion menu
lsp.tsserver.setup{
    capabilities=capabilities,
    filetypes = { 'javascript', 'typescript', 'typescriptreact' }, 
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false -- avoid conflicts with prettier
        on_attach(client)
    end
}
lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        signs = true,
        virtual_text = false,
    })

cmd [[
sign define LspDiagnosticsSignError text=🔻 linehl= numhl=
sign define LspDiagnosticsSignWarning text=🔸 linehl= numhl=
sign define LspDiagnosticsSignInformation text=🔹 linehl= numhl=
sign define LspDiagnosticsSignHint text=👉 linehl= numhl=
]]

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights

local filetypes = {
    typescript = "eslint",
    javascript = "eslint",
    typescriptreact = "eslint",
}

local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "warning", [1] = "error"}
    }
}

local formatters = {
    prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
}

local formatFiletypes = {
    typescript = "prettier",
    javascript = "prettier",
    typescriptreact = "prettier"
}

lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

-- Abbreviations / Remapping / Other key bindings --

cmd 'cnoreabbrev W! w!'
cmd 'cnoreabbrev Q! q!'
cmd 'cnoreabbrev Qall! qall!'
cmd 'cnoreabbrev Wq wq'
cmd 'cnoreabbrev Wa wa'
cmd 'cnoreabbrev wQ wq'
cmd 'cnoreabbrev WQ wq'
cmd 'cnoreabbrev W w'
cmd 'cnoreabbrev Q q'
cmd 'cnoreabbrev Qall qall'

g.fzf_layout = { window = { width=0.9, height=0.6}}
cmd "noremap <leader>/ :Rg "
cmd "nnoremap <C-p> :FZF<CR>"
