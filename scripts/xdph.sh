#!/usr/bin/env bash

tag=v1.3.9
git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland.git
cd xdg-desktop-portal-hyprland/
git checkout $tag

cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build

sudo cmake --install build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf xdg-desktop-portal-hyprland
    exit 1
fi
cd ..
rm -rf xdg-desktop-portal-hyprland
