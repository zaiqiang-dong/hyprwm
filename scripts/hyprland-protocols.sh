#!/usr/bin/env bash

tag=v0.7.1

git clone https://github.com/hyprwm/hyprland-protocols.git
cd hyprland-protocols
git checkout $tag
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local -S . -B ./build
sudo cmake --install ./build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf hyprland-protocols
    exit 1
fi
cd ..
rm -rf hyprland-protocols
