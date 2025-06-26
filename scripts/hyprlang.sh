#!/usr/bin/env bash

tag=v0.6.3
git clone https://github.com/hyprwm/hyprlang.git
cd hyprlang
git checkout $tag
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..
rm -rf hyprlang
