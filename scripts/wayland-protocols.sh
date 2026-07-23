#!/usr/bin/env bash

sudo apt install -y --quiet meson ninja-build pkg-config libwayland-dev git

VERSION="${1:-1.49}"
PREFIX="/usr"

git clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git
cd wayland-protocols
git checkout "$VERSION"

meson setup build --prefix="$PREFIX" --buildtype=release
ninja -C build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf wayland-protocols
    exit 1
fi

sudo ninja -C build install
pkg-config --modversion wayland-protocols

cd ..
rm -rf wayland-protocols
