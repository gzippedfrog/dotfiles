":PlugInstall
call plug#begin()
	Plug 'itchyny/lightline.vim'
call plug#end()

let mapleader =" "

syntax on

" Use system clipboard
set clipboard+=unnamedplus

" Tab is 4 spaces
set tabstop=4
set shiftwidth=4

set mouse=a
set number

" Don't display current mode
set noshowmode

" Toggle text highlight
noremap <leader>s :set hlsearch! hlsearch?<CR>

" Replace all is aliased to S
nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
