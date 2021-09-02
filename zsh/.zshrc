## aliases

## general
alias s="sudo"
alias v="vim"
alias sv="sudo vim"
alias stow="stow -t ~/ -v --ignore '.DS_Store' --ignore '.git'"
alias wttr="curl https://www.wttr.in"
alias la="ls -la"

## pacman
#alias p="sudo pacman"
#alias upg="sudo pacman -Syu"

## apt
#alias ap="sudo apt"
#alias upg="sudo apt update && sudo apt upgrade"

## soystemd 
#alias off="systemctl poweroff"
#alias reb="systemctl reboot"
#alias sus="systemctl suspend"
#alias bios="systemctl reboot --firmware-setup"

## enable colors and change prompt
autoload -U colors && colors	# load colors
#PS1="%{$fg[green]%}%~%{$reset_color%}> "
PS1="%B%{$fg[green]%}%n@%M%{$fg[white]%}:%{$fg[blue]%}%~%{$reset_color%}$ "
setopt autocd	# automatically cd into typed directory.

## history in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
HISTDIR=~/.cache/zsh
HISTFILE=$HISTDIR/history
[[ ! -f $HISTFILE ]] && mkdir -p $HISTDIR; touch $HISTDIR/history

## basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	# include hidden files.

## load plugins
ZSHDIR=~/.config/zsh

if [ ! -d $ZSHDIR/zsh-autosuggestions ] && [ -x "$(command -v git)" ]; then
	mkdir -p $ZSHDIR
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZSHDIR/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSHDIR/zsh-syntax-highlighting
fi

source $ZSHDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh