#!/usr/bin/env bash

git clone https://github.com/Alexays/Waybar
cd Waybar

if [[ -f /usr/local/bin/waybar ]]; then
    echo "-------- waybar build second times -------"
    meson setup build -Dtests=disabled
else
    echo "-------- waybar build first times -------"
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
