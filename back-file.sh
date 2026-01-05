#!/usr/bin/env bash

cp -r ~/.config/hypr ./config/

if lsmod | grep -q "nvidia"; then
    cp ./config/hypr/gpu.conf ./config/hypr/nvidia.conf
    git checkout ./config/hypr/gpu.conf
fi

git checkout ./config/hypr/workspace.conf
cp -r ~/.config/waybar ./config/
cp -r ~/.config/rofi ./config/
cp -r ~/.config/swaync ./config/
cp -r ~/.config/gtk-3.0 ./config/
cp -r ~/.config/gtk-4.0 ./config/
cp -r ~/.gtkrc-2.0 ./config/gtk-2.0/gtkrc-2.0
