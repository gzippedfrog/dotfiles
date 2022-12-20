#!/bin/bash

# check if wsl is used
grep -qi microsoft /proc/version &&
    IS_WSL=true ||
    IS_WSL=false


if [ ! $IS_WSL ]; then
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
fi

# install zsh4humans
if command -v curl >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
    sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
