export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"

[ -x "$(command -v nvim)" ] && EDITOR="nvim" || EDITOR="vim" # prefer neovim to regular vim
source ~/.config/aliasrc # load aliases if present

## enable colors and change prompt
autoload -U colors && colors	# load colors
PS1="[%{$fg[green]%}%~%{$reset_color%}] "
# PS1="%B%{$fg[green]%}%n@%M%{$fg[white]%}:%{$fg[blue]%}%~%{$reset_color%}$ "
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
_comp_options+=(globdots)		# include hidden files

## emacs-like movement for macOS
bindkey "ƒ" forward-word
bindkey "∫" backward-word

## load plugins
if [ ! -d $ZDOTDIR/zsh-autosuggestions ] && [ -x "$(command -v git)" ]; then
	mkdir -p $ZDOTDIR
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/zsh-autosuggestions
	git clone https://github.com/zdharma/fast-syntax-highlighting $ZDOTDIR/fast-syntax-highlighting
fi

source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh