#!/usr/bin/env bash


git clone git@github.com:hyprwm/hyprland-guiutils.git
tag=v0.2.1
cd hyprland-guiutils
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release -j$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)
sudo cmake --install build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf hyprland-guiutils
    exit 1
fi
cd ..
rm -rf hyprland-guiutils

