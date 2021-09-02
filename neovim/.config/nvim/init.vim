set clipboard+=unnamedplus
set tabstop=4
set shiftwidth=4
syntax on
set bg=dark
set mouse=a

nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!