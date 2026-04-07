#!/usr/bin/env bash

git clone git@github.com:hyprwm/hyprtoolkit.git
tag=v0.5.3
cd hyprtoolkit
git checkout $tag
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build

if [ $? -ne 0 ]; then
    cd ..
    rm -rf hyprtoolkit
    exit 1
fi

cd ..
rm -rf hyprtoolkit
