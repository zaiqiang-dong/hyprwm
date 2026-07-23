#!/usr/bin/env bash

sudo apt install -y --quiet meson ninja-build pkg-config libffi-dev libxml2-dev git

VERSION="${1:-1.26.0}"
PREFIX="/usr"

git clone https://gitlab.freedesktop.org/wayland/wayland.git
cd wayland
git checkout "$VERSION"

meson setup build --prefix="$PREFIX" --buildtype=release -Ddocumentation=false
ninja -C build
if [ $? -ne 0 ]; then
    cd ..
    rm -rf wayland
    exit 1
fi

sudo ninja -C build install
wayland-scanner --version

cd ..
rm -rf wayland
