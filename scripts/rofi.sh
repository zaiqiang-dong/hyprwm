#!/usr/bin/env bash

sudo apt-get install -y bison
sudo apt-get install -y flex
sudo apt-get install -y pandoc
sudo apt-get install -y doxygen
sudo apt-get install -y cppcheck
sudo apt-get install -y imagemagick
sudo apt-get install -y libmpdclient-dev
sudo apt-get install -y libnl-3-dev
sudo apt-get install -y libasound2-dev
sudo apt-get install -y libstartup-notification0-dev
sudo apt-get install -y libwayland-client++1
sudo apt-get install -y libwayland-dev
sudo apt-get install -y libcairo-5c-dev
sudo apt-get install -y libcairo2-dev
sudo apt-get install -y libpango1.0-dev
sudo apt-get install -y libgdk-pixbuf-2.0-dev
sudo apt-get install -y libxcb-keysyms1-dev
sudo apt-get install -y libwayland-client0
sudo apt-get install -y libxcb-ewmh-dev
sudo apt-get install -y libxcb-cursor-dev
sudo apt-get install -y libxcb-icccm4-dev
sudo apt-get install -y libxcb-randr0-dev
sudo apt-get install -y libxcb-render-util0-dev
sudo apt-get install -y libxcb-util-dev
sudo apt-get install -y libxcb-xkb-dev
sudo apt-get install -y libxcb-xinerama0-dev
sudo apt-get install -y libxkbcommon-dev
sudo apt-get install -y libxkbcommon-x11-dev
sudo apt-get install -y ohcount
sudo apt-get install -y wget

rofi_tag="1.7.8+wayland1"
wget https://github.com/lbonn/rofi/releases/download/1.7.8%2Bwayland1/rofi-1.7.8+wayland1.tar.gz
tar xf rofi-$rofi_tag.tar.gz
cd rofi-$rofi_tag || exit 1
meson setup build && ninja -C build
sudo ninja -C build install
cd .. || exit 1
rm -rf rofi-$rofi_tag.tar.gz
rm -rf rofi-$rofi_tag
