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
export TORRSERVER_CONFIG="$XDG_CONFIG_HOME"/torrserver
export AZURE_CONFIG_DIR=$XDG_DATA_HOME/azure
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc

export EDITOR=nvim

if uname -r | grep -qi 'WSL'; then
    source $ZDOTDIR/.zshenv;
fi