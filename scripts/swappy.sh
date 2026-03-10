#!/usr/bin/env bash

git clone https://github.com/jtheoof/swappy.git

cd swappy
meson setup build
ninja -C build

sudo cp ./build/swappy /usr/bin
cd ..
rm swappy -rf
