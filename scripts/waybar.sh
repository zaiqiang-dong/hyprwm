#!/usr/bin/env bash

git clone https://github.com/Alexays/Waybar
cd Waybar

meson setup build
# meson setup build -Dtests=disabled
ninja -C build
sudo ninja -C build install
if [ $? -ne 0 ]; then
    cd ..
    rm -rf Waybar
    exit 1
fi

cd ..
rm -rf Waybar
