set nocompatible
set encoding=utf-8
set background=dark
set backspace=indent,eol,start

syntax on
filetype plugin indent on

let g:solarized_termcolors=256

let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1

colorscheme solarized

packadd minpac

call minpac#init({'verbose': 3})

call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-surround')
call minpac#add('junegunn/fzf')
call minpac#add('mhinz/vim-grepper')
call minpac#add('ervandew/supertab')
call minpac#add('ruanyl/vim-gh-line')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('w0rp/ale')

call minpac#add('k-takata/minpac', {'type': 'opt'})

"HTML specific
call minpac#add('mattn/emmet-vim')

"Javascript specific
call minpac#add('pangloss/vim-javascript')
call minpac#add('mxw/vim-jsx')
call minpac#add('raichoo/purescript-vim')

"Python specific
call minpac#add('vim-scripts/indentpython.vim')

nnoremap <C-p> :<C-u>FZF<CR>

"by default, the indent is 4 spaces.
set sts=4
set sw=4
set sw=4
set expandtab
set autoindent

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

"for python files, 4 spaces
autocmd Filetype python setlocal ts=4 sw=4 sts=4 foldmethod=indent foldlevel=79

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.js,*.html,*.css match BadWhitespace /\s\+$/

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.js set tabstop=2 softtabstop=2 shiftwidth=2

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()


" Ale configuartions
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'python': ['pylint'],
\ }

" Mappings in the style of unimpaired-next, using k instead ow `w`
" easier for dvorak layout.
nmap <silent> [K <Plug>(ale_first)
nmap <silent> [k <Plug>(ale_previous)
nmap <silent> ]k <Plug>(ale_next)
nmap <silent> ]K <Plug>(ale_last)

" Grepper config
let g:grepper       = {}
let g:grepper.tools = ['rg', 'grep']
"let g:grepper.prompt_quote = 1

" Search for the current word
nnoremap <Leader>g :Grepper -tool rg<CR>
nnoremap <Leader>G :Grepper -tool grep<CR>
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
