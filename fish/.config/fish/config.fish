# prefer neovim to regular vim
if command -sq nvim
    set EDITOR "nvim"
else
    set EDITOR "vim" 
end

set TEST "a"
set LESSHISTFILE -
set TEST $TEST "b"
set PATH $PATH ~/.local/bin

## aliases

## general
alias v="$EDITOR"
alias wttr="curl https://www.wttr.in"
alias s="sudo"
alias sv="sudo $EDITOR"
alias stow="stow -t ~/ -v --ignore '\.DS_Store' --ignore '\.git'"
alias la="ls -la"

## pacman
# alias p="sudo pacman"
# alias upg="sudo pacman -Syu"

## apt
# alias ap="sudo apt"
# alias upg="sudo apt update && sudo apt upgrade"

## soystemd 
# alias off="systemctl poweroff"
# alias reb="systemctl reboot"
# alias susp="systemctl suspend"
# alias bios="systemctl reboot --firmware-setup"

if status --is-interactive
    abbr --add --global stowdir ~/.config/stow
end