#!/usr/bin/env bash
tag=v0.2.1

git clone https://github.com/hyprwm/hyprwire.git
cd hyprwire
git checkout $tag

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release -j$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)
sudo cmake --install build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf hyprwire
    exit 1
fi
cd ..
rm -rf hyprwire
