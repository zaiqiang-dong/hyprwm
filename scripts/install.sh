#!/usr/bin/env bash

sudo apt-get install -y libdisplay-info-dev
sudo apt-get install -y libpugixml-dev
sudo apt-get install -y libudis86-dev
sudo apt-get install -y libxcursor-dev
sudo apt-get install -y libxcb-errors-dev
sudo apt-get install -y libtomlplusplus-dev
sudo apt-get install -y libsdbus-c++-dev

./hyprlang.sh
./hyprwayland-scanner.sh
./hyprutils.sh
./aquamarine.sh
./hyprgraphics.sh
./hyprland.sh
./hyprlock.sh
./hyprland-protocols.sh
./hypridle.sh

