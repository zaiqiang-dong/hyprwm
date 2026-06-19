#!/usr/bin/env bash

git clone https://github.com/Alexays/Waybar
cd Waybar

if [[ -f /usr/local/bin/waybar ]]; then
    meson setup build -Dtests=disabled
else
    meson setup build
fi
ninja -C build
sudo ninja -C build install
if [ $? -ne 0 ]; then
    cd ..
    rm -rf Waybar
    exit 1
fi

cd ..
rm -rf Waybar
