#!/usr/bin/env bash

# wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
sudo snap install icon-theme-papirus
sudo apt install papirus-icon-theme
sudo mv /usr/share/icons/gnome /usr/share/icons/back-gnome
sudo mv /usr/share/icons/Papirus-Dark /usr/share/icons/gnome
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
