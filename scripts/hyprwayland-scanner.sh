#!/usr/bin/env bash

sudo apt install libpugixml-dev

tag=v0.4.4
git clone https://github.com/hyprwm/hyprwayland-scanner.git
cd hyprwayland-scanner
git checkout $tag
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
sudo cmake --install build
cd ..
rm -rf hyprwayland-scanner
