[ -x "(command -v nvim)" ] && export EDITOR=nvim || export EDITOR=vim
[ -e ~/.local/bin ] && set PATH $PATH:(find ~/.local/bin -maxdepth 2 -type d | tr '\n' ':')
[ -e ~/.config/aliases ] && source ~/.config/aliases
