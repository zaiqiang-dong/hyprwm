#!/usr/bin/env bash
tag=v0.13.0

git clone https://github.com/Alexays/Waybar
cd Waybar
git checkout $tag

meson setup build
ninja -C build
sudo ninja -C build install

cd ..
# rm -rf Waybar
