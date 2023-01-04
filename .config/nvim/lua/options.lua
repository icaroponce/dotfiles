local o = vim.opt
local g = vim.g

g.mapleader = ","

o.number = true
o.relativenumber = true
o.numberwidth = 2

o.backspace = { "indent", "eol", "start" }
o.pumheight = 20
o.completeopt = { "menu", "menuone", "noselect" } -- Completion options
-- opt.wildmode = {'list', 'longest'} -- Command-line completion mode

o.ignorecase = true -- ignore case when searching
o.smartcase = true -- smart case when searching
o.hlsearch = true -- highlight same words when searching
o.incsearch = true -- updates the searching match hl while typing
o.hidden = true -- hides mouse pointer when typing
o.showmatch = true -- show matching brackets
-- opt.matchtime = 2

-- disable errors beeps
o.errorbells = false
o.visualbell = false

-- more natural split
o.splitbelow = true
o.splitright = true

o.cursorline = true
o.autoread = true -- auto read file changes
o.grepprg = "rg --vimgrep --no-heading --smart-case"

o.encoding = "utf-8"
o.history = 5000
o.swapfile = false
o.signcolumn = "yes"
o.ruler = true
o.expandtab = true
o.wrap = true
o.termguicolors = true
o.showmode = false -- get rid of the -- INSERT --
o.clipboard = "unnamedplus"
o.shortmess = o.shortmess + "c"
