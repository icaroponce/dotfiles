" ****************************************************************************
"  Basic Setup
" ****************************************************************************
set nocompatible
set encoding=utf-8
set backspace=indent,eol,start

syntax on
filetype plugin indent on

source ~/dotfiles/packages.vim

let g:mapleader=','
set history=5000
set noswapfile
set ruler

"by default, the indent is 4 spaces.
set sts=4
set sw=4
set sw=4
set expandtab
set showcmd
set autoindent
set nopaste     " enable formatting while pasting
set showmatch   " highlight matching brackets
set hlsearch    " highlight same words while searching with Shift +
" set number
" set relativenumber

""for html/js/jsx/ruby files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 sts=2
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2
autocmd Filetype javascript.jsx setlocal ts=2 sw=2 sts=2
autocmd Filetype jsx setlocal ts=2 sw=2 sts=2
autocmd Filetype json setlocal ts=2 sw=2 sts=2
autocmd Filetype ruby setlocal ts=2 sw=2 sts=2
autocmd Filetype css setlocal ts=2 sw=2 sts=2
autocmd Filetype scss setlocal ts=2 sw=2 sts=2
autocmd Filetype less setlocal ts=2 sw=2 sts=2
autocmd Filetype vim setlocal ts=2 sw=2 sts=2

"for python files, 4 spaces
autocmd Filetype python setlocal ts=4 sw=4 sts=4 foldmethod=indent foldlevel=79 textwidth=79

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.js,*.html,*.css match BadWhitespace /\s\+$/

" ****************************************************************************
"  Visual Preferences
" ****************************************************************************
set background=dark

"colorscheme solarized
"let g:airline_theme = 'behelit'
"let g:solarized_termcolors=256
"
colorscheme gruvbox

let g:gruvbox_termcolors = 256
let g:airline_powerline_fonts = 1

let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark='medium'

" ****************************************************************************
"  Plugins Customization
" ****************************************************************************
" built-in directory browser config
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"    autocmd!
"    autocmd VimEnter * :Vexplore
"augroup END

" Change default gh map to open github link on browser
let g:gh_line_map_default = 0
let g:gh_line_map = '<leader>o'

" jedi-vim configuration
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>gt"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
" let g:jedi#smart_auto_mappings = 0

" Ale configuartions
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'python': ['pylint'],
\ }

let g:ale_fixers = {
\ 'python': ['pylint'],
\ 'javascript': ['eslint'],
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }

"*****************************************************************************
" Abbreviations / Remapping / Other Key bindings
"*****************************************************************************
""" no one is really happy until you have these shortcuts
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

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Grepper config
let g:grepper       = {}
let g:grepper.tools = ['rg', 'grep']

nnoremap <C-p> :<C-u>FZF<CR>

command! Path call EchoPath()
function! EchoPath ()
  echo join(split(&runtimepath, ','), "\n")
endfunction

" Mappings in the style of unimpaired-next, using k instead ow `w`
" easier for dvorak layout.
nmap <silent> [K <Plug>(ale_first)
nmap <silent> [k <Plug>(ale_previous)
nmap <silent> ]k <Plug>(ale_next)
nmap <silent> ]K <Plug>(ale_last)

" Search for the current word
nnoremap <Leader>g :Grepper -tool rg<CR>
nnoremap <Leader>G :Grepper -tool grep<CR>
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
