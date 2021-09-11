# prefer neovim to regular vim
if command -sq nvim
    set EDITOR "nvim"
else
    set EDITOR "vim"
end

set LESSHISTFILE -
set PATH $PATH:(find ~/.local/bin -maxdepth 1 -type d -printf ":%p")

set XDG_DATA_DIRS $XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/gzfrog/.local/share/flatpak/exports/share

#source ~/.config/aliases


## general
abbr s "sudo"
abbr v "$EDITOR"
abbr sv "sudo $EDITOR"
abbr stow "stow -t ~/ -v --ignore '.DS_Store'"
abbr wttr "curl https://www.wttr.in"
abbr la "ls -hla --color=auto --group-directories-first" # Linux
abbr la "ls -hlaG" # MacOS

## pacman
# alias p "sudo pacman"
# alias upg "sudo pacman -Syu"

## apt
alias ap "sudo apt"
alias upg "sudo apt update && sudo apt upgrade; flatpak update; sudo snap refresh"

## soystemd
alias off "systemctl poweroff"
alias reb "systemctl reboot"
alias susp "systemctl suspend"
alias bios "systemctl reboot --firmware-setup"
