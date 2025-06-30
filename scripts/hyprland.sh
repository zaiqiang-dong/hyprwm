#!/usr/bin/env bash

tag=v0.47.0
git clone --recursive https://github.com/hyprwm/Hyprland.git
cd Hyprland
git checkout $tag
make all && sudo make install
cd ..
rm -rf Hyprland
