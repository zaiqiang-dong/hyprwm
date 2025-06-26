#!/usr/bin/env bash

sudo apt install libpugixml-dev

tag=0.4.4
git clone --recursive -b $tag https://github.com/hyprwm/hyprlang.git
cd hyprwayland-scanner
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
sudo cmake --install build
