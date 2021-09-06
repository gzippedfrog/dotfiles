# prefer neovim to regular vim
if command -sq nvim
    set EDITOR "nvim"
else
    set EDITOR "vim" 
end

set LESSHISTFILE -
set PATH $PATH ~/.local/bin

source ~/.config/aliases

if status --is-interactive
    abbr --add --global stowdir ~/.config/stow
end