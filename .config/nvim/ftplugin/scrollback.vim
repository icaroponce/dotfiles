set clipboard^=unnamedplus
set signcolumn=no
set nolist
set laststatus=0
set scrolloff=0
set nowrapscan
set relativenumber

xnoremap <buffer> <cr> "+y
nnoremap <buffer> q <cmd>q!<cr>
nnoremap <buffer> i <cmd>q!<cr>
nnoremap <buffer> I <cmd>q!<cr>
nnoremap <buffer> A <cmd>q!<cr>
nnoremap <buffer> H H
nnoremap <buffer> L L

if exists(':HideBadWhiteSpace')
    HideBadWhiteSpace
endif

call cursor(line('$'), 0)
silent! call search('\S', 'b')
silent! call search('\n*\%$')
execute "normal! \<c-y>"
