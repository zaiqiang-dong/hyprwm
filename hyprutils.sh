#!/usr/bin/env bash

tag=v0.7.1
git clone https://github.com/hyprwm/hyprutils.git
cd hyprutils/
git checkout $tag
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build
