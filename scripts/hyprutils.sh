#!/usr/bin/env bash

tag=v0.8.0
git clone https://github.com/hyprwm/hyprutils.git
cd hyprutils/
git checkout $tag
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)
sudo cmake --install build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf hyprutils
    exit 1
fi
cd ..
rm -rf hyprutils
