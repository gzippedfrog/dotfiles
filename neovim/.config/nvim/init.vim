let mapleader =","

syntax on
set title
set clipboard+=unnamedplus
set tabstop=4
set shiftwidth=4
set bg=dark
set mouse=a
set number
set noshowmode
set noshowcmd
set laststatus=0

map <leader>v :Vexplore<Return>
map <leader>h :Sexplore<Return>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Toggle text highlight
	noremap <leader>s :set hlsearch! hlsearch?<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
