#!/usr/bin/env bash

host=$(uname -a | cut -d " " -f 2)

if [[ $host == "NBJT" ]]; then
    echo "config host : $host"
    sed -i 's|monitor=,highres,auto,2|monitor = DP-1, 3840x2160@60, 0x0, 2\nmonitor = HDMI-A-1, 3840x2160@60, 1920x0, 2|g' ./config/hypr/monitors.conf
    cp ./workspace/NBJT/workspace.conf ./config/hypr/workspace.conf
    sed -i 's|\"DP-5\"\: \[1, 2, 3, 4, 5\]|\"DP-1\"\: \[1, 2, 3, 4, 5\]|g' ./config/waybar/config.jsonc
    sed -i 's|\"DP-6\"\: \[6, 7, 8, 9, 10, 11\]|\"HDMI-A-1\"\: \[6, 7, 8, 9, 10, 11\]|g' ./config/waybar/config.jsonc
fi

if [[ $host == "NBGT" ]]; then
    echo "config host : $host"
    cp ./workspace/NBGT/workspace.conf ./config/hypr/workspace.conf
fi

if [[ $host == "NBGB" ]]; then
    echo "config host : $host"
    sed -i 's|exec-once = echo \"Xft\.dpi\:192\" \| xrdb -merge|\# exec-once = echo \"Xft\.dpi\:192\" \| xrdb -merge|g' ./config/hypr/env.conf
    sed -i 's|monitor=,highres,auto,2|monitor=,highres,auto,1|g' ./config/hypr/monitors.conf
    sed -i '/\"DP-5\"\: \[1, 2, 3, 4, 5\]/d' ./config/waybar/config.jsonc
    sed -i '/\"DP-6\"\: \[6, 7, 8, 9, 10, 11\]/d' ./config/waybar/config.jsonc
    cp ./workspace/NBGB/workspace.conf ./config/hypr/workspace.conf
fi

cp -r ./config/* ~/.config/
cp ./config/gtk-2.0/gtkrc-2.0 ~/.gtkrc-2.0
cp ./themes ~/.local/share/ -r

if [[ -e ~/.config/gtk-4.0 ]]; then
    rm ~/.config/gtk-4.0 -rf
fi
ln -s ~/.local/share/themes/Catppuccin-Green-Dark/gtk-4.0 ~/.config/gtk-4.0

git checkout .

gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Green-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font Ultra-Bold 14"
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
