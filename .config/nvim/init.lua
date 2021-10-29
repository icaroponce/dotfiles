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
opt.completeopt = {'menu','menuone', 'noselect'} -- Completion options
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
opt.wrap = true
opt.termguicolors = true
opt.showmode = false -- get rido fo the -- INSERT --
opt.clipboard = 'unnamedplus'
cmd "set shortmess+=c"

g['mapleader'] = ','

g['python3_host_prog'] = '~/.pyenv/versions/neovim3/bin/python'
g['python_host_prog'] = '~/.pyenv/versions/neovim2/bin/python'

local packer = require('packer')
packer.startup(function()
  -- Packer can manage itself --
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-eunuch' -- vim sugar for UNIX shell cmds
    use 'tpope/vim-unimpaired' -- [ ] aliases
    use 'tpope/vim-fugitive' -- vim plugin for Git
    use 'tpope/vim-rhubarb'
    use 'sheerun/vim-polyglot'

    use 'nvim-treesitter/nvim-treesitter'
    use {
        "ray-x/lsp_signature.nvim",
        config = 'require "lsp_signature".setup({ floating_window = true })',
    }
    use 'neovim/nvim-lspconfig'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind-nvim',
        }
    }

    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview'
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'hoob3rt/lualine.nvim'
    use 'machakann/vim-highlightedyank'
    use 'justinmk/vim-dirvish'

    use {
        'windwp/nvim-autopairs',
        config = 'require "nvim-autopairs".setup()'
    }

    use 'terryma/vim-expand-region'

    use 'lukas-reineke/indent-blankline.nvim'

    use 'EdenEast/nightfox.nvim'

    use 'norcalli/nvim-colorizer.lua'

    use {'plasticboy/vim-markdown', requires = {'godlygeek/tabular'}}

    use 'tpope/vim-commentary'

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = 'require "gitsigns".setup()'
    }

    use {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
    }
end)

local colorizer = require 'colorizer'
colorizer.setup {
    '*';
    css = { rgb_fn = true };
    typescript = { rgb_fn = true };
    javascript = { rgb_fn = true };
}

local nightfox = require 'nightfox'
nightfox.setup({
        fox = 'nightfox',
        styles = {
            comments = "italic", -- change style of comments to be italic
            keywords = "bold", -- change style of keywords to be bold
            functions = "italic" -- styles can be a comma separated list
        },
    })
nightfox.load();

local lualine = require 'lualine'
lualine.setup({
        options = {
            theme = 'nightfox',
            icons_enabled = false,
            section_separators = '',
            component_separators = '',
            extensions = {'quickfix'}
        }
    })

local ts = require 'nvim-treesitter.configs'
ts.setup {
    ensure_installed = 'maintained',
    highlight = {enable = true}
}

-- telescope configuration --
local telescope = require 'telescope'
local telescope_actions = require "telescope.actions"
telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = telescope_actions.move_selection_next,
                ["<C-k>"] = telescope_actions.move_selection_previous,
            },
        },
    }
}

map('n', '<C-p>', '<cmd>Telescope find_files<cr>')
map('n', '<leader>/', '<cmd>Telescope live_grep<cr>')
map('n', "<leader>'", '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- nvim-tree configuration --
cmd('autocmd BufEnter NvimTree set cursorline')
-- cmd('highlight NvimTreeFolderIcon guibg=red')
-- cmd('highlight NvimTreeOpenedFile guibg=red guifg=green')

local tree = require 'nvim-tree'

g.nvim_tree_indent_markers = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 1

tree.setup {
    hijack_cursor = true;
    update_focused_file = {
        enable = true;
    }
}

map('n', "<leader>t", '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>r', '<cmd>NvimTreeRefresh<CR>')

-- lsp configuration --
local lsp = require 'lspconfig'
local cmp = require 'cmp'
local lspkind = require "lspkind"
local luasnip = require 'luasnip'

cmp.setup {
    -- compe.preselect = 'always' equivalent
    -- completion = {
    --    completeopt = 'menu,menuone,noinsert',
    --  },
    formatting = {
        format = lspkind.cmp_format({with_text = true, maxwidth = 50})
    },
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },
    mapping = {
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
                fallback()
            end
        end,
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'calc' },
        { name = 'emoji' },
        { name = 'path' },
        { name = 'buffer' },
    }
}

local format_async = function(err, result, ctx, config)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(ctx.bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, ctx.bufnr)
        vim.fn.winrestview(view)
        if ctx.bufnr == vim.api.nvim_get_current_buf() then
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lsp.pylsp.setup { on_attach = on_attach, capabilities = capabilities }
lsp.tsserver.setup{
    capabilities = capabilities,
    filetypes = { 'javascript', 'typescript', 'typescriptreact' }, 
    root_dir = function() return vim.loop.cwd() end,
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false -- avoid conflicts with prettier
        on_attach(client)
    end
}

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

map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights
map('n','<leader>h', ':Gitsigns preview_hunk<CR>')

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
