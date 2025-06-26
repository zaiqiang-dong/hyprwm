#!/usr/bin/env bash

tag=v0.8.2
git clone https://github.com/hyprwm/hyprlock.git
cd hyprlock
git checkout $tag
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
