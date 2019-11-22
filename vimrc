" ****************************************************************************
"  Basic Setup
" ****************************************************************************
set nocompatible
set encoding=utf-8
set backspace=indent,eol,start
set hidden
set shortmess+=c
set signcolumn=yes
set cmdheight=2
set termguicolors

syntax on
"filetype plugin indent on

call plug#begin('~/.vim/plugged')

Plug 'Tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"Plug 'w0rp/ale'
Plug 'mhinz/vim-grepper'
Plug 'ruanyl/vim-gh-line'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'janko-m/vim-test'
Plug 'machakann/vim-highlightedyank'
Plug 'Valloric/MatchTagAlways'
Plug 'Raimondi/delimitMate'
Plug 'tomasr/molokai'

Plug 'junegunn/vim-easy-align' "gaip
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Completion
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

"HTML specific
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color' "highlight hex and rgb colors

"CSS specific
"Plug 'styled-components/vim-styled-components'

  "Markdown specific
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

"Javascript specific
"Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
"Plug 'maxmellon/vim-jsx-pretty'
"Plug 'raichoo/purescript-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
"Plug 'chemzqm/vim-jsx-improve'

"Typescript specific
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'mhartington/nvim-typescript'
"Plug 'leafgarland/typescript-vim'

"Python specific
Plug 'vim-scripts/indentpython.vim'

"colorschemes
Plug 'morhetz/gruvbox'

call plug#end()

command! PackUpdate source $MYVIMRC | redraw | PlugInstall
command! PackClean  source $MYVIMRC | PlugClean

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
"set autoindent
set nopaste     " enable formatting while pasting
set showmatch   " highlight matching brackets
set hlsearch    " highlight same words while searching with Shift +
set number
set relativenumber
set clipboard+=unnamedplus

""for html/js/jsx/ruby files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 sts=2
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2
autocmd Filetype javascript.jsx setlocal ts=2 sw=2 sts=2
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2
autocmd Filetype typescript.tsx setlocal ts=2 sw=2 sts=2
autocmd Filetype jsx setlocal ts=2 sw=2 sts=2
autocmd Filetype json setlocal ts=2 sw=2 sts=2
autocmd Filetype ruby setlocal ts=2 sw=2 sts=2
autocmd Filetype css setlocal ts=2 sw=2 sts=2
autocmd Filetype scss setlocal ts=2 sw=2 sts=2
autocmd Filetype less setlocal ts=2 sw=2 sts=2
autocmd Filetype vim setlocal ts=2 sw=2 sts=2

"for python files, 4 spaces
autocmd Filetype python setlocal ts=4 sw=4 sts=4 foldmethod=indent foldlevel=79 textwidth=79


" ****************************************************************************
"  Visual Preferences
" ****************************************************************************
set background=dark

"colorscheme solarized
"let g:airline_theme = 'dark'
"let g:solarized_termcolors=256
"
"
"let g:gruvbox_italic = 1
"colorscheme gruvbox
"let g:gruvbox_termcolors = 256
"let g:gruvbox_contrast_dark='medium'

colorscheme molokai
let g:rehash256 = 1
"let g:imolokai_original = 1

let g:airline_powerline_fonts=1

highlight TermCursor ctermfg=red guifg=red

" ****************************************************************************
"  Neovim's Terminal customization
" ****************************************************************************
" switches to normal mode by pressing Esc
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif

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
let g:gh_line_map = '<leader>gh'
let g:gh_line_blame_map = '<leader>gb'
let g:gh_open_command = 'xdg-open '

" vim-test
let g:test#strategy = "dispatch"
let g:test#python#runner = 'pytest'
let g:dispatch_compilers = {}
let g:dispatch_compilers['pytest'] = 'pytest'

"let g:ale_fix_on_save = 1
"let g:ale_linters = {
"      \ 'python': ['pylint'],
"      \ }

"let g:ale_fixers = {
"      \ 'python': ['pylint'],
"      \ 'javascript': ['eslint'],
"      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
"      \ }
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

" Grepper config
let g:grepper       = {}
let g:grepper.tools = ['rg', 'grep']

nnoremap <C-p> :<C-u>FZF<CR>

command! Path call EchoPath()
function! EchoPath ()
  echo join(split(&runtimepath, ','), "\n")
endfunction

" Search for the current word
nnoremap <Leader>g :Grepper -tool rg<CR>
nnoremap <Leader>G :Grepper -tool grep<CR>
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

autocmd VimEnter * hi Normal ctermbg=none

"set completeopt=noinsert,menuone,longest

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Use `[k` and `]k` for navigate diagnostics
nmap <silent> [k <Plug>(coc-diagnostic-prev)
nmap <silent> ]k <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" -------------------------------------------------
"  iamcco/markdown-preview
" -------------------------------------------------
"let g:mkdp_refresh_slow=1

" -------------------------------------------------
"  plasticboy/vim-markdown
" -------------------------------------------------
autocmd FileType markdown normal zR
command! -nargs=0 Prettier :CocCommand prettier.formatFile
