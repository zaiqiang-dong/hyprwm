#!/usr/bin/env bash

tag=v0.6.4

git clone https://github.com/hyprwm/hyprland-protocols.git
cd hyprland-protocols
git checkout $tag
meson setup build
sudo meson install -C build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf hyprland-protocols
    exit 1
fi
cd ..
rm -rf hyprland-protocols
