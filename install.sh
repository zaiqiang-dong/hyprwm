#!/usr/bin/env bash

sudo apt-get install -y build-essential
sudo apt-get install -y cmake
sudo apt-get install -y cmake-extras
sudo apt-get install -y curl
sudo apt-get install -y findutils
sudo apt-get install -y gawk
sudo apt-get install -y gettext
sudo apt-get install -y gir1.2-graphene-1.0
sudo apt-get install -y git
sudo apt-get install -y glslang-tools
sudo apt-get install -y gobject-introspection
sudo apt-get install -y golang
sudo apt-get install -y hwdata
sudo apt-get install -y jq
sudo apt-get install -y libavcodec-dev
sudo apt-get install -y libavformat-dev
sudo apt-get install -y libavutil-dev
sudo apt-get install -y libcairo2-dev
sudo apt-get install -y libdeflate-dev
sudo apt-get install -y libdisplay-info-dev
sudo apt-get install -y libdrm-dev
sudo apt-get install -y libegl-dev
sudo apt-get install -y libegl1-mesa-dev
sudo apt-get install -y libgbm-dev
sudo apt-get install -y libgdk-pixbuf-2.0-dev
sudo apt-get install -y libgdk-pixbuf2.0-bin
sudo apt-get install -y libgirepository1.0-dev
sudo apt-get install -y libgl1-mesa-dev
sudo apt-get install -y libgraphene-1.0-0
sudo apt-get install -y libgraphene-1.0-dev
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y libgulkan-dev
sudo apt-get install -y libinih-dev
sudo apt-get install -y libinput-dev
sudo apt-get install -y libjbig-dev
sudo apt-get install -y libjpeg-dev
sudo apt-get install -y libjpeg62-dev
sudo apt-get install -y liblerc-dev
sudo apt-get install -y libliftoff-dev
sudo apt-get install -y liblzma-dev
sudo apt-get install -y libnotify-bin
sudo apt-get install -y libpam0g-dev
sudo apt-get install -y libpango1.0-dev
sudo apt-get install -y libpipewire-0.3-dev
sudo apt-get install -y libqt6svg6
sudo apt-get install -y libseat-dev
sudo apt-get install -y libstartup-notification0-dev
sudo apt-get install -y libswresample-dev
sudo apt-get install -y libsystemd-dev
sudo apt-get install -y libtiff-dev
sudo apt-get install -y libtiffxx6
sudo apt-get install -y libtomlplusplus-dev
sudo apt-get install -y libudev-dev
sudo apt-get install -y libvkfft-dev
sudo apt-get install -y libvulkan-dev
sudo apt-get install -y libvulkan-volk-dev
sudo apt-get install -y libwayland-dev
sudo apt-get install -y libwebp-dev
sudo apt-get install -y libxcb-composite0-dev
sudo apt-get install -y libxcb-cursor-dev
sudo apt-get install -y libxcb-dri3-dev
sudo apt-get install -y libxcb-ewmh-dev
sudo apt-get install -y libxcb-icccm4-dev
sudo apt-get install -y libxcb-present-dev
sudo apt-get install -y libxcb-render-util0-dev
sudo apt-get install -y libxcb-res0-dev
sudo apt-get install -y libxcb-util-dev
sudo apt-get install -y libxcb-xinerama0-dev
sudo apt-get install -y libxcb-xinput-dev
sudo apt-get install -y libxcb-xkb-dev
sudo apt-get install -y libxkbcommon-dev
sudo apt-get install -y libxkbcommon-x11-dev
sudo apt-get install -y libxkbregistry-dev
sudo apt-get install -y libxml2-dev
sudo apt-get install -y libxxhash-dev
sudo apt-get install -y make
sudo apt-get install -y meson
sudo apt-get install -y ninja-build
sudo apt-get install -y openssl
sudo apt-get install -y psmisc
sudo apt-get install -y python3-mako
sudo apt-get install -y python3-markdown
sudo apt-get install -y python3-markupsafe
sudo apt-get install -y python3-yaml
sudo apt-get install -y python3-pyquery
sudo apt-get install -y qt6-base-dev
sudo apt-get install -y scdoc
sudo apt-get install -y seatd
sudo apt-get install -y spirv-tools
sudo apt-get install -y unzip
sudo apt-get install -y vulkan-validationlayers
sudo apt-get install -y wayland-protocols
sudo apt-get install -y xdg-desktop-portal
sudo apt-get install -y xwayland
sudo apt-get install -y bc
sudo apt-get install -y qt6-quick3d-dev
sudo apt-get install -y qt6-declarative-dev
sudo apt-get install -y qt6-wayland-dev
sudo apt-get install -y libmagic-dev
sudo apt-get install -y libdisplay-info-dev
sudo apt-get install -y libpugixml-dev
sudo apt-get install -y libudis86-dev
sudo apt-get install -y libxcursor-dev
sudo apt-get install -y libxcb-errors-dev
sudo apt-get install -y libtomlplusplus-dev
sudo apt-get install -y libsdbus-c++-dev
sudo apt-get install -y libzip-dev
sudo apt-get install -y librsvg2-dev
sudo apt-get install -y libre2-dev
sudo apt-get install -y libspa-0.2-dev
sudo apt-get install -y sway-notification-center
sudo apt-get install -y slurp
sudo apt-get install -y wl-clipboard
sudo apt-get install -y grim
sudo apt-get install -y xdg-desktop-portal-phosh
sudo apt-get install -y lm-sensors
sudo apt-get install -y cliphist
sudo apt-get install -y copyq
sudo apt-get install -y libqt5printsupport5t64

./scripts/waybar.sh
./scripts/rofi.sh
./scripts/hyprutils.sh
./scripts/hyprlang.sh
./scripts/hyprwayland-scanner.sh
./scripts/aquamarine.sh
./scripts/hyprgraphics.sh
./scripts/hyprcursor.sh
./scripts/hyprland.sh
./scripts/hyprlock.sh
./scripts/hyprland-protocols.sh
./scripts/hypridle.sh
./scripts/hyprqtutils.sh
./scripts/theme.sh
./scripts/xdph.sh
./scripts/uwsm.sh
./scripts/worksapce.sh
./scripts/satty.sh
./scripts/sceensave.sh


cp -r ./config/* ~/.config/

# if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -qi "nvidia"; then
#     echo "use nvidia gpu"
#     ./scripts/nvidia.sh
#     cp ./config/hypr/nvidia.conf ~/.config/hypr/gpu.conf
# fi

