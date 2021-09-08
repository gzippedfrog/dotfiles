# prefer neovim to regular vim
if command -sq nvim
    set EDITOR "nvim"
else
    set EDITOR "vim" 
end

set LESSHISTFILE -
set PATH $PATH:(find ~/.local/bin -maxdepth 1 -type d -printf ":%p")

set XDG_DATA_DIRS $XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/gzfrog/.local/share/flatpak/exports/share

source ~/.config/aliases
