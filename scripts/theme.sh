#!/usr/bin/env bash

sudo apt-get install -y papirus-icon-theme
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
sudo snap install icon-theme-papirus
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
