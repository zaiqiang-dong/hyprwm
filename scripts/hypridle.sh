#!/usr/bin/env bash
tag=v0.1.6

git clone https://github.com/hyprwm/hypridle.git
cd hypridle
git checkout $tag

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hypridle -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build

cd ..
rm -rf hypridle

