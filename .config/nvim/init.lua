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
cmd "filetype plugin indent on"

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

opt.cursorline = true
opt.autoread = true -- auto read file changes
opt.grepprg = "rg --vimgrep --no-heading --smart-case"

-- default tab 4 spaces

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
    use 'tpope/vim-surround'
    use 'sheerun/vim-polyglot'
    use { 'ndmitchell/ghcid', rtp = 'plugins/nvim' }

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
    use 'neovimhaskell/haskell-vim'
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
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

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
 options = {
  transparent = false,
    styles = {
      comments = "italic",
      functions = "italic",
      keywords = "bold",
    }
  }
})
cmd('colorscheme nightfox')

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
    highlight = {enable = true},
    -- indent = {enable = true}
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
    },
    pickers = {
        lsp_code_actions = {
            layout_config = {
                horizontal = {
                    height = 0.3;
                    width = 0.7
                }

            }
        }
    }
}

map('n', '<C-p>', '<cmd>Telescope find_files<cr>')
map('n', '<leader>/', '<cmd>Telescope live_grep<cr>')
map('n', "<leader>'", '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>gs', '<cmd>Telescope git_status<cr>')
map('n', 'ca', '<cmd>Telescope lsp_code_actions<cr>')

-- nvim-tree configuration --
cmd('autocmd BufEnter NvimTree* set cursorline')

local tree = require 'nvim-tree'
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
local types = require "luasnip.util.types"

luasnip.config.set_config {
  updateevents = "TextChanged,TextChangedI",
  store_selection_keys = "<c-j>",
  ext_opts = {
    [types.insertNode] = {
      passive = {
        hl_group = "Substitute",
      },
    },
    [types.choiceNode] = {
      active = {
        virt_text = { { "choiceNode", "IncSearch" } },
      },
    },
  },
}

vim.cmd [[
  imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'
  imap <silent><expr> <c-k>  luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev': '<c-k>'
  imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice': '<c-e>'
  snoremap <silent> <c-j> <cmd>lua require'luasnip'.jump(1)<Cr>
  snoremap <silent> <c-k> <cmd>lua require'luasnip'.jump(-1)<Cr>
  vnoremap <c-f>  "ec<cmd>lua require('luasnip.extras.otf').on_the_fly()<cr>
  inoremap <c-f>  <cmd>lua require('luasnip.extras.otf').on_the_fly('e')<cr>
]]

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
            select = false,
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

-- local format_async = function(err, result, ctx, config)
--     if err ~= nil or result == nil then return end
--     if not vim.api.nvim_buf_get_option(ctx.bufnr, "modified") then
--         local view = vim.fn.winsaveview()
--         vim.lsp.util.apply_text_edits(result, ctx.bufnr)
--         vim.fn.winrestview(view)
--         if ctx.bufnr == vim.api.nvim_get_current_buf() then
--             vim.api.nvim_command("noautocmd :update")
--         end
--     end
-- end
-- vim.lsp.handlers["textDocument/formatting"] = format_async

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
    cmd("command! LspFormattingSync lua vim.lsp.buf.formatting_seq_sync(nil, 1000)")
    cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    cmd("command! LspHover lua vim.lsp.buf.hover()")
    cmd("command! LspRename lua vim.lsp.buf.rename()")
    cmd("command! LspOrganize lua lsp_organize_imports()")
    cmd("command! LspRefs lua vim.lsp.buf.references()")
    cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    cmd(
        "command! LspDiagLine lua vim.diagnostic.open_float()")
    cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
    buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
    buf_map(bufnr, "n", "ga", ":LspFormatting<CR>", {silent = true})
    buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
    buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
    buf_map(bufnr, "n", "gi", ":LspOrganize<CR>", {silent = true})
    buf_map(bufnr, "n", "[k", ":LspDiagPrev<CR>", {silent = true})
    buf_map(bufnr, "n", "]k", ":LspDiagNext<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
        {silent = true})
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
        client.resolved_capabilities.document_formatting = false -- avoid conflicts with eslint server
        on_attach(client)
    end
}
lsp.eslint.setup {
    settings = {
      format = true
    },
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        on_attach(client)
        cmd('autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx :LspFormattingSync')
    end
}

lsp.hls.setup({
  on_attach = on_attach,
  settings = {
    haskell = {
      formattingProvider = "fourmolu"
    }
  }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        signs = true,
        virtual_text = false,
    })

cmd [[
sign define DiagnosticSignError text=🔻 linehl= numhl=
sign define DiagnosticSignWarn text=🔸 linehl= numhl=
sign define DiagnosticSignInfo text=🔹 linehl= numhl=
sign define DiagnosticSignHint text=👉 linehl= numhl=
]]

map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights
map('n','<leader>h', ':Gitsigns preview_hunk<CR>')
map('n','<leader>gb', ':Gitsigns blame_line<CR>')

-- easier map to ":"
map('n', '<Space>', ':', { silent = false })
map('x', '<Space>', ':', { silent = false })

cmd [[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall
]]

g.haskell_classic_highlighting = 1
g.haskell_indent_do = 4
g.haskell_indent_case = 4
g.haskell_indent_if = 4
g.haskell_indent_in = 4
g.haskell_indent_guard = 4
g.haskell_indent_before_where = 2
g.haskell_indent_after_bare_where = 2
g.haskell_indent_case_alternative = 4
