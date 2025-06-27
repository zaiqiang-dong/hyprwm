#!/usr/bin/env bash

tag=v0.1.12
git clone https://github.com/hyprwm/hyprcursor.git
cd hyprcursor
git checkout %tag
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf hyprcursor
