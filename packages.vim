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
call minpac#add('tpope/vim-dispatch')
call minpac#add('w0rp/ale')
call minpac#add('junegunn/fzf')
call minpac#add('mhinz/vim-grepper')
call minpac#add('ervandew/supertab')
call minpac#add('ruanyl/vim-gh-line')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('vim-airline/vim-airline')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('janko-m/vim-test')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('autozimu/LanguageClient-neovim')
"call minpac#add('Shougo/deoplete.nvim')
"call minpac#add('Valloric/YouCompleteMe')
call minpac#add('roxma/nvim-yarp')
call minpac#add('Shougo/neco-syntax')
call minpac#add('Shougo/neco-vim')

call minpac#add('ncm2/ncm2')
call minpac#add('ncm2/ncm2-bufword')
call minpac#add('ncm2/ncm2-path')
call minpac#add('ncm2/ncm2-tern')
call minpac#add('ncm2/ncm2-cssomni')
call minpac#add('ncm2/ncm2-syntax')
call minpac#add('ncm2/ncm2-vim')
call minpac#add('ncm2/ncm2-jedi')
call minpac#add('fgrsnau/ncm-otherbuf')
call minpac#add('ncm2/nvim-typescript')

call minpac#add('k-takata/minpac', {'type': 'opt'})

"HTML specific
call minpac#add('mattn/emmet-vim')

"Javascript specific
call minpac#add('pangloss/vim-javascript')
call minpac#add('mxw/vim-jsx')
call minpac#add('raichoo/purescript-vim')

"Typescript specific
call minpac#add('HerringtonDarkholme/yats.vim')
call minpac#add('mhartington/nvim-typescript')

"Python specific
call minpac#add('vim-scripts/indentpython.vim')
call minpac#add('davidhalter/jedi-vim')

"Colorschemes
call minpac#add('morhetz/gruvbox')
