#!/usr/bin/env bash

tag=v0.52.2
git clone --recursive https://github.com/hyprwm/Hyprland.git
cd Hyprland
git checkout $tag
make all && sudo make install
if [ $? -ne 0 ]; then
    cd ..
    rm -rf Hyprland
    exit 1
fi
cd ..
rm -rf Hyprland
