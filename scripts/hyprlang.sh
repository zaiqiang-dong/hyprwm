#!/usr/bin/env bash

tag=v0.6.7
git clone https://github.com/hyprwm/hyprlang.git
cd hyprlang
git checkout $tag
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)
sudo cmake --install ./build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf hyprlang
    exit 1
fi
cd ..
rm -rf hyprlang
