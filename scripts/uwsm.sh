#!/usr/bin/env bash

tag=v0.25.3

git clone https://github.com/Vladimir-csp/uwsm.git
cd uwsm
git checkout $tag

meson setup --prefix=/usr/local -Duuctl=enabled -Dfumon=enabled -Duwsm-app=enabled build
sudo meson install -C build

if [ $? -ne 0 ]; then
    cd ..
    rm -rf uwsm
    exit 1
fi
cd ..
rm -rf uwsm
