#!/usr/bin/env bash

wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
sudo snap install icon-theme-papirus
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
