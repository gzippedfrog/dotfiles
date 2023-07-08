export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export GPG_TTY="$TTY"
export NVM_CONFIG="$XDG_CONFIG_HOME"/nvm
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export DOTNET_CLI_HOME="$XDG_CONFIG_HOME"/dotnet
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export PROJ_DIR="$HOME"/Projects
export DOTS_DIR="$XDG_CONFIG_HOME"/dotfiles
export EDITOR="nvim"
export TORRSERVER_CONFIG="$XDG_CONFIG_HOME/torrserver"

source "$ZDOTDIR/.zshenv"