#!/usr/bin/env bash

tag=v0.6.4

git clone https://github.com/hyprwm/hyprland-protocols
cd hyprland-protocols
git checkout $tag
meson setup build
sudo meson install -C build
cd ..
rm -rf hyprland-protocols
