#!/usr/bin/env bash

wget -qO- https://git.io/papirus-icon-theme-install | sh
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
# gsettings set org.gnome.desktop.interface icon-theme "Yaru-dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
