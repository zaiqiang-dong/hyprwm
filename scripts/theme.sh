#!/usr/bin/env bash

sudo apt-get install -y papirus-icon-theme
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
echo "======================================================================================================"
echo "======================================================================================================"
echo "need download Papirus theme form"
echo "https://launchpad.net/~papirus/+archive/ubuntu/papirus/+packages?field.name_filter=papirus-icon-theme"
echo "======================================================================================================"
echo "======================================================================================================"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
