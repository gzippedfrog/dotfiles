#!/bin/bash

# istall essential packages
PACKAGES='
    zsh
    neovim 
    git 
    stow
    tldr
    neofetch
    gnome-software
    gnome-sushi
    gnome-tweaks
    flatpak
    gnome-software-plugin-flatpak
    mpv
    fonts-firacode
'

[ -x "$(command -v apt)" ] &&
    sudo apt update &&
    sudo apt upgrade &&
    sudo apt install $PACKAGES

STOW_DIRS='
    zsh
    git
    neovim
    mpv
    gnome-ubuntu
'

stow -t ~ $STOW_DIRS

# dont ask current user for a password when using sudo
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee --append /etc/sudoers >/dev/null

# generate ssh key
ssh-keygen -t ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub

# add flathub repo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# enable X11 backend and hardware acceleration for mpv
sudo sed -i 's/\(^Exec=.*\) \(-- .*$\)/\1 --gpu-context=x11egl --hwdec=vaapi-copy \2/' /usr/share/applications/mpv.desktop

# improve font rendering
# in flatseal add xdg-config/fontconfig:ro

XRESOURCES_CONF='
    Xft.antialias: 1
    Xft.hinting: 0
    Xft.autohint: 0
    Xft.rgba: rgb
    Xft.hintstyle: hintslight
    Xft.lcdfilter: lcddefault
'

echo "$XRESOURCES_CONF" | sed '/^$/ d' >$HOME/.Xresources

xrdb -merge ~/.Xresources

sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
sudo fc-cache -fv

# fix windows time conflict
timedatectl set-local-rtc 1 --adjust-system-clock

# change gnome dash to dock settings
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

# install zsh4humans
if command -v curl >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
    sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
