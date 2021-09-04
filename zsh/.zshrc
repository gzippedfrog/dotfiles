export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"
[ -x "$(command -v nvim)" ] && export EDITOR="nvim" || export EDITOR="vim"

source ~/.config/aliasrc # load aliases if present


bindkey -e
## enable colors and change prompt
autoload -U colors && colors	# load colors
PS1="[%{$fg[cyan]%}%~%{$reset_color%}] "
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

## emacs-like movement
bindkey "ƒ" forward-word
bindkey "∫" backward-word

## history search with Shift + Up/Down
bindkey ";2A" history-beginning-search-backward
bindkey ";2B" history-beginning-search-forward

## load plugins
if [ ! -d $ZDOTDIR/zsh-autosuggestions ] && [ -x "$(command -v git)" ]; then
	mkdir -p $ZDOTDIR
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/zsh-autosuggestions
	git clone https://github.com/zdharma/fast-syntax-highlighting $ZDOTDIR/fast-syntax-highlighting
fi

source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh