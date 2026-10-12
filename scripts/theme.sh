#!/usr/bin/env bash
# wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
sudo snap install icon-theme-papirus
sudo apt install papirus-icon-theme
sudo cp -Lr /usr/share/icons/Papirus-Dark/22x22/places/. /usr/share/icons/Papirus-Dark/16x16/places/

