[ -x "$(command -v nvim)" ] && EDITOR="nvim" || EDITOR="vim"
export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"

## aliases

## general
alias s="sudo"
alias v="${EDITOR}"
alias sv="sudo ${EDITOR}"
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
HISTFILE="$HISTDIR/history"
[ ! -f $HISTFILE ] && mkdir -p $HISTDIR; touch $HISTDIR/history

## basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	# include hidden files.

## load plugins
if [ ! -d $ZDOTDIR/zsh-autosuggestions ] && [ -x "$(command -v git)" ]; then
	mkdir -p $ZDOTDIR
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZDOTDIR/zsh-syntax-highlighting
fi

source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh