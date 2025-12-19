#!/usr/bin/env bash

tag=v0.1.4

git clone https://github.com/hyprwm/hyprland-qtutils.git
cd hyprland-qtutils
git checkout $tag

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)

sudo cmake --install build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf hyprland-qtutils
    exit 1
fi
cd ..
rm -rf hyprland-qtutils
