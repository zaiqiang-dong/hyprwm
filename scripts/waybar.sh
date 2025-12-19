#!/usr/bin/env bash

# waybar depend
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y gobject-introspection
sudo apt-get install -y libgirepository1.0-dev
sudo apt-get install -y libpulse-dev
sudo apt-get install -y libnl-3-dev
sudo apt-get install -y libdbusmenu-gtk3-dev
sudo apt-get install -y libmpdclient-dev
sudo apt-get install -y libsndio-dev
sudo apt-get install -y libevdev-dev
sudo apt-get install -y libxkbregistry-dev
sudo apt-get install -y upower
sudo apt-get install -y libsigc++-3.0-dev
sudo apt-get install -y fmtools
sudo apt-get install -y libjsoncpp-dev
sudo apt-get install -y libfftw3-dev
sudo apt-get install -y libspdlog-dev
sudo apt-get install -y libiniparser-dev
sudo apt-get install -y libgtkmm-3.0-dev
sudo apt-get install -y libnl-genl-3-dev
sudo apt-get install -y libinotifytools0-dev
sudo apt-get install -y libpipewire-0.3-dev
sudo apt-get install -y playerctl
sudo apt-get install -y libinotify-ocaml-dev

tag=v0.13.0

git clone https://github.com/Alexays/Waybar
cd Waybar
git checkout $tag

meson setup build
ninja -C build
sudo ninja -C build install
if [ $? -ne 0 ]; then
    cd ..
    rm -rf Waybar
    exit 1
fi

cd ..
rm -rf Waybar
