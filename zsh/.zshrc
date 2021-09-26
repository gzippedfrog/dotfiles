export ZDOTDIR=~/.config/zsh
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:~/local/share/flatpak/exports/share

[ -e ~/.local/bin ] && export PATH=$PATH:$(find ~/.local/bin -maxdepth 2 -type d | tr '\n' ':')
[ -x "$(command -v nvim)" ] && export EDITOR="nvim" || export EDITOR="vim"
[ -e ~/.config/aliases ] && source ~/.config/aliases

# enable colors and change prompt
autoload -U colors && colors	# load colors
PS1="[%B%{$fg[green]%}%~%{$reset_color%}]$ "
setopt autocd	# automatically cd into typed directory.

# history in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
HISTDIR=~/.cache/zsh
HISTFILE="$HISTDIR/history"
[ ! -f $HISTFILE ] && mkdir -p $HISTDIR; touch $HISTDIR/history

# basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# include hidden files

bindkey -e

# history search
bindkey "^[f" history-beginning-search-backward
bindkey "^[b" history-beginning-search-forward

# load plugins
if [ ! -d $ZDOTDIR/zsh-autosuggestions ] && [ -x "$(command -v git)" ]; then
	mkdir -p $ZDOTDIR
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/zsh-autosuggestions
	git clone https://github.com/zdharma/fast-syntax-highlighting $ZDOTDIR/fast-syntax-highlighting
fi

source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
