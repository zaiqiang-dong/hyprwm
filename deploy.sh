#!/usr/bin/env bash

host=$(uname -a | cut -d " " -f 2)

if [[ $host == "NBJT" ]]; then
    echo "config host NBJT"
    sed -i '/hl\.monitor({/,/})/c\hl.monitor({\n  output = "DP-1",\n  mode = "3840x2160@60",\n  position = "0x0",\n  scale = 2,\n})\n\nhl.monitor({\n  output = "HDMI-A-1",\n  mode = "3840x2160@60",\n  position = "1920x0",\n  scale = 2,\n})' ./config/hypr/monitors.lua

    sed -i 's|\"DP-5\"\: \[1, 2, 3, 4, 5\]|\"DP-1\"\: \[1, 2, 3, 4, 5\]|g' ./config/waybar/config.jsonc
    sed -i 's|\"DP-6\"\: \[6, 7, 8, 9, 10, 11\]|\"HDMI-A-1\"\: \[6, 7, 8, 9, 10, 11\]|g' ./config/waybar/config.jsonc

    cp ./workspace/NBJT/workspace.lua ./config/hypr/workspace.lua

elif [[ $host == "NBGT" ]]; then
    echo "config host NBGT"
    cp ./workspace/NBGT/workspace.lua ./config/hypr/workspace.lua

elif [[ $host == "NBGB" ]]; then
    echo "config host NBGB"

    sed -i 's|scale = 2|scale = 1|g' ./config/hypr/monitors.lua
    sed -i '/hl\.env("GDK_SCALE", "2")/d;/hl\.env("QT_FONT_DPI", "144")/d' ./config/hypr/env.lua

    sed -i '/\"DP-5\"\: \[1, 2, 3, 4, 5\]/d' ./config/waybar/config.jsonc
    sed -i '/\"DP-6\"\: \[6, 7, 8, 9, 10, 11\]/d' ./config/waybar/config.jsonc

    cp ./workspace/NBGB/workspace.lua ./config/hypr/workspace.lua
fi

# 部署配置文件到 ~/.config
cp -r ./config/* ~/.config/
cp ./config/gtk-2.0/gtkrc-2.0 ~/.gtkrc-2.0

# 链接主题目录
if [[ ! -e ~/.local/share/themes ]]; then
    ln -s "$(realpath themes)" ~/.local/share/themes
fi

if [[ -e ~/.config/gtk-4.0 ]]; then
    rm -rf ~/.config/gtk-4.0
fi
ln -s ~/.local/share/themes/Catppuccin-Green-Dark/gtk-4.0 ~/.config/gtk-4.0

# 还原工作区改动
git checkout .
git clean -df

# GTK / GNOME 外观设置
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Green-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font Bold 13"
gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"
gsettings set org.gnome.desktop.interface cursor-size "24"
gsettings set org.gnome.desktop.interface toolbar-style "both-horiz"
gsettings set org.gnome.desktop.interface toolbar-icons-size "large"
gsettings set org.gnome.desktop.interface font-hinting "slight"
gsettings set org.gnome.desktop.interface font-antialiasing "grayscale"
gsettings set org.gnome.desktop.interface font-rgba-order "rgb"
gsettings set org.gnome.desktop.interface text-scaling-factor "1.0"
gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
gsettings set org.gnome.desktop.interface event-sounds "true"
gsettings set org.gnome.desktop.interface input-feedback-sounds "true"
