command! PackUpdate packadd minpac | source $MYVIMRC | redraw | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

if !exists('*minpac#init')
  finish
endif

call minpac#init({'verbose': 0})

call minpac#add('tpope/vim-eunuch')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-surround')
call minpac#add('w0rp/ale')
call minpac#add('junegunn/fzf')
call minpac#add('mhinz/vim-grepper')
call minpac#add('ervandew/supertab')
call minpac#add('ruanyl/vim-gh-line')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('vim-airline/vim-airline')
" call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('terryma/vim-multiple-cursors')

call minpac#add('k-takata/minpac', {'type': 'opt'})

"HTML specific
call minpac#add('mattn/emmet-vim')

"Javascript specific
call minpac#add('pangloss/vim-javascript')
call minpac#add('mxw/vim-jsx')
call minpac#add('raichoo/purescript-vim')

"Python specific
call minpac#add('vim-scripts/indentpython.vim')
call minpac#add('davidhalter/jedi-vim')

"Colorschemes
call minpac#add('morhetz/gruvbox')
