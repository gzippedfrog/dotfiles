# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update 'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard 'pc'

# Don't start tmux.
zstyle ':z4h:' start-tmux no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv' enable 'no'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1' enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*' enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Start ssh-agent if it's not running yet.
zstyle ':z4h:ssh-agent:' start yes

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
# z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(
    ~/.local/bin
    ~/.config/composer/vendor/bin
    $path
)

# Source additional local files if they exist.
# z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
# This is just an example that you should delete. It does nothing useful.
# z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
# z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
z4h bindkey z4h-backward-kill-word Ctrl+Backspace Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab # undo the last command line change
z4h bindkey redo Alt+/            # redo the last undone command line change

z4h bindkey z4h-cd-back Alt+Left     # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right # cd into the next directory
z4h bindkey z4h-cd-up Alt+Up         # cd into the parent directory
z4h bindkey z4h-cd-down Alt+Down     # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function update_flatpaks_and_snaps() {
    [ $(command -v flatpak) ] && flatpak update
    [ $(command -v snap) ] && sudo snap refresh
}

function md() {
    [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" 
}

compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d wind=$z4h_win_home
[[ -z $PROJ_DIR ]] || hash -d proj=$PROJ_DIR
[[ -z $DOTS_DIR ]] || hash -d dots=$DOTS_DIR
[[ -z $XDG_CONFIG_HOME ]] || hash -d conf=$XDG_CONFIG_HOME

# Define aliases
alias tree="tree -a -I .git"
alias s="sudo"
alias v="$EDITOR"
alias sv="sudo -e"
alias la="ls -hla --color=auto --group-directories-first"
alias lsblk="lsblk | grep -v '^loop'"
alias ka="killall"
alias ska="sudo killall"
alias ts="torrserver -d $TORRSERVER_CONFIG"

# git
alias gta="git add ."
alias gtc="git commit -m"
alias gtp="git push"
alias gtu="git reset HEAD~"
alias gts="git status"

# laravel
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"

# dnf
if (grep -qi "fedora" /proc/version); then
    alias pm=" sudo dnf"
    alias pmi="sudo dnf install"
    alias pmu="sudo dnf update && 
               update_flatpaks_and_snaps"
    alias pmr="sudo dnf remove"
    alias pmp="sudo dnf purge"
    alias pma="sudo dnf autoremove"
    alias pms="sudo dnf search"
fi

# apt/nala
if (grep -qiE "ubuntu|wsl" /proc/version); then
    [ "$(command -v nala)" ] &&
        alias pm="sudo nala" ||
        alias pm="sudo apt"

    alias pmi="pm install"
    alias pmu="pm update && pm upgrade && update_flatpaks_and_snaps"
    alias pmr="pm remove"
    alias pmp="pm purge"
    alias pma="pm autoremove"
    alias pms="pm search"
fi

# Add flags to existing aliases.
#alias ls="${aliases[ls]:-ls} -A"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots    # no special treatment for file names with a leading dot
setopt no_auto_menu # require an extra TAB press to open the completion menu

# [WSL] Fix tab duplication in windows terminal
grep -qi 'wsl' /proc/version &&
    IS_WSL=true ||
    IS_WSL=false

if $IS_WSL; then
    keep_current_path() {
        printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
    }

    precmd_functions+=(keep_current_path)
fi

# Load nvm
[ -s "$NVM_CONFIG/nvm.sh" ] && \. "$NVM_CONFIG/nvm.sh"

# Start torrserver
if (command -v torrserver &> /dev/null); then
    [ ! -d $TORRSERVER_CONFIG ] &&
        mkdir $TORRSERVER_CONFIG

    [ ! "$(pgrep torrserver &> /dev/null)" ] &&
        (nohup torrserver -d $TORRSERVER_CONFIG &>/dev/null &)
fi