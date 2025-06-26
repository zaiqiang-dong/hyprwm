#!/usr/bin/env bash

sudo apt install libpugixml-dev
tag=v0.8.0
git clone https://github.com/hyprwm/aquamarine.git
cd aquamarine
git checkout $tag
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf aquamarine
