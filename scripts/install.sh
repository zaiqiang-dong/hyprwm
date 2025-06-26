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



# hyprwm
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

