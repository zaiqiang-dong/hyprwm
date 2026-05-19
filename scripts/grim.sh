#!/usr/bin/env bash
git clone https://git.sr.ht/~emersion/grim
cd grim
meson build
ninja -C build
ninja -C build install
cd ..
rm grim -rf
