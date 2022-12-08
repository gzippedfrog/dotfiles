if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
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

" Toggle search highlight
noremap <leader>h :set hlsearch! hlsearch?<CR>

" Replace all is aliased to S
nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
