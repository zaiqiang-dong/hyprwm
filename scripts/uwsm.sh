#!/usr/bin/env bash

tag=v0.23.0

git clone https://github.com/Vladimir-csp/uwsm.git
cd uwsm
git checkout $tag

meson setup --prefix=/usr/local -Duuctl=enabled -Dfumon=enabled -Duwsm-app=enabled build
meson install -C build

cd ..
rm -rf uwsm
