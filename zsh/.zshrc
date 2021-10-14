ZDOTDIR=~/.config/zsh
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:~/.local/share/flatpak/exports/share

[ -e ~/.local/bin ] && export PATH=$PATH:$(find ~/.local/bin -maxdepth 2 -type d | tr '\n' ':')
[ -x "$(command -v nvim)" ] && export EDITOR="nvim" || export EDITOR="vim"
[ -e ~/.config/aliases ] && source ~/.config/aliases

# load plugins and theme
if [ ! -d $ZDOTDIR/zgen ] && [ -x "$(command -v git)" ]; then
	mkdir -p $ZDOTDIR/zgen
	git clone https://github.com/tarjoilija/zgen.git $ZDOTDIR/zgen
fi

export ZGEN_DIR=$ZDOTDIR/zgen

source $ZDOTDIR/zgen/zgen.zsh

if ! zgen saved; then

  zgen oh-my-zsh
  #zgen oh-my-zsh themes/fwalch
  zgen oh-my-zsh themes/robbyrussell
  zgen oh-my-zsh plugins/command-not-found
  zgen load zdharma/fast-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions

  zgen save
fi

# enable colors and change prompt
#autoload -U colors && colors	# load colors
#PS1="[%B%{$fg[green]%}%~%{$reset_color%}]$ "
#setopt autocd	# automatically cd into typed directory.
unsetopt PROMPT_SP

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

# correct spelling
setopt correct

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^W' backward-kill-word

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';;      # block
        viins|main) echo -ne '\e[6 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

# history search
bindkey "^[k" history-beginning-search-backward
bindkey "^[j" history-beginning-search-forward
