set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'pangloss/vim-javascript'
" Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'oinksoft/npm.vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'godlygeek/tabular'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'powerline/powerline'
Plugin 'ryanoasis/vim-devicons'
Plugin 'elixir-lang/vim-elixir'
Plugin 'mxw/vim-jsx'

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
set sts=4
set sw=4
set sw=4
set expandtab
set autoindent

"for html/js/jsx/ruby files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 sts=2
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2
autocmd Filetype javascript.jsx setlocal ts=2 sw=2 sts=2
autocmd Filetype jsx setlocal ts=2 sw=2 sts=2
autocmd Filetype json setlocal ts=2 sw=2 sts=2
autocmd Filetype ruby setlocal ts=2 sw=2 sts=2

"for python/css files, 4 spaces
autocmd Filetype python setlocal ts=4 sw=4 sts=4 
autocmd Filetype css setlocal ts=4 sw=4 sts=4


let g:airline_powerline_fonts = 1 
let g:Powerline_symbols='unicode'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

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

set ttimeoutlen=50
set encoding=utf-8
set t_Co=256
set laststatus=2
syntax on

" let g:xml_syntax_folding = 1
let g:jsx_ext_required = 0

set background=dark

"let g:solarized_termcolors=16
let g:solarized_termcolors=256
colorscheme solarized
" highlight Comment ctermfg=darkgray


" Syntastic configuration
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers=['eslint']
