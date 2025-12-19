#!/usr/bin/env bash

sudo apt install libpugixml-dev

tag=v0.4.5
git clone https://github.com/hyprwm/hyprwayland-scanner.git
cd hyprwayland-scanner
git checkout $tag
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j $(nproc)
sudo cmake --install build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf hyprwayland-scanner
    exit 1
fi
cd ..
rm -rf hyprwayland-scanner
