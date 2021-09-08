export LESSHISTFILE="-"
export ZDOTDIR="$HOME/.config/zsh"
export PATH=$PATH:$(find ~/.local/bin -maxdepth 1 -type d -printf ":%p")
#export XDG_DATA_DIRS="/usr/share/ubuntu/:/usr/local/share/:/usr/share/:/var/lib/snapd/desktop"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/gzfrog/.local/share/flatpak/exports/share"
[ -x "$(command -v nvim)" ] && export EDITOR="nvim" || export EDITOR="vim"

source ~/.config/aliases # load aliases if present

## enable colors and change prompt
autoload -U colors && colors	# load colors
PS1="[%B%{$fg[green]%}%~%{$reset_color%}]$ "
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

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

## emacs-like movement
# bindkey "ƒ" forward-word
# bindkey "∫" backward-word

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
