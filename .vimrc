set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'csscomb/vim-csscomb.git'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'isRuslan/vim-es6'
Plugin 'godlygeek/tabular'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'powerline/powerline'

call vundle#end()            " required
filetype plugin indent on    " required

let g:user_emmet_settings = {
\	'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

map <C-h> :NERDTreeToggle<CR>

""beautifiers
"for js
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
"for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
"for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType javascript.jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType javascript.jsx vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
"for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
"for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

"by default, the indent is 4 spaces. 
"set shiftwidth=4
"set softtabstop=4
"set tabstop=4

"for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 noexpandtab
autocmd Filetype javascript set ts=2 sw=2 noexpandtab
autocmd Filetype javascript.jsx set ts=2 sw=2 noexpandtab
autocmd Filetype jsx set ts=2 sw=2 noexpandtab
autocmd Filetype ruby setlocal ts=2 sw=2 noexpandtab

"for js/coffee/jade files, 4 spaces
autocmd Filetype python setlocal ts=4 sw=4 sts=4 noexpandtab
autocmd Filetype css setlocal ts=4 sw=4 sts=0 noexpandtab

"set laststatus=2
"set tabstop=4
"set shiftwidth=4

let g:airline_powerline_fontsi = 1 
let g:Powerline_symbols='unicode'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'


let g:airline_mode_map = {
	\ '__' : '-',
      	\ 'n'  : 'N',
     	 \ 'i'  : 'I',
      	\ 'R'  : 'R',
      	\ 'c'  : 'C',
      	\ 'v'  : 'V',
      	\ 'V'  : 'V',
      	\ '' : 'V',
      	\ 's'  : 'S',
      	\ 'S'  : 'S',
      	\ '' : 'S',
\ }

"let g:airline_theme = 'powerlineish'
"let g:airline#extensions#hunks#enabled=0
"let g:airline#extensions#branch#enabled=1

set ttimeoutlen=50
set encoding=utf-8
set t_Co=256
set laststatus=2
