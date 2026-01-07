#!/usr/bin/env bash

# wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
sudo snap install icon-theme-papirus
sudo apt install papirus-icon-theme

gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Green-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font Ultra-Bold 12"
gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"
gsettings set org.gnome.desktop.interface cursor-size "24"
gsettings set org.gnome.desktop.interface toolbar-style "both-horiz"
gsettings set org.gnome.desktop.interface toolbar-icons-size "large"
gsettings set org.gnome.desktop.interface font-hinting "slight"
gsettings set org.gnome.desktop.interface font-antialiasing "grayscale"
gsettings set org.gnome.desktop.interface font-rgba-order "rgb"
gsettings set org.gnome.desktop.interface text-scaling-factor "1.0"
gsettings set org.gnome.desktop.interface color-scheme "default"
gsettings set org.gnome.desktop.interface event-sounds "true"
gsettings set org.gnome.desktop.interface input-feedback-sounds "true"
