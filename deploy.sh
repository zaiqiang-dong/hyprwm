#!/usr/bin/env bash

host=$(uname -a | cut -d " " -f 2)

if [[ host == "NBJT" ]]; then
    sed -i 's|monitor=,highres,auto,2|monitor = DP-1, 3840x2160@60, 0x0, 2\nmonitor = HDMI-A-1, 3840x2160@60, 1920x0, 2|g' ./config/hypr/monitors.conf
    cp ./workspace/NBJT/workspace.conf ./config/hypr/workspace.conf
    sed -i 's|\"DP-5\"\: \[1, 2, 3, 4, 5\]|\"DP-1\"\: \[1, 2, 3, 4, 5\]|g' ./config/waybar/config.jsonc
    sed -i 's|\"DP-6\"\: \[6, 7, 8, 9, 10, 11\]|\"HDMI-A-1\"\: \[6, 7, 8, 9, 10, 11\]|g' ./config/waybar/config.jsonc
fi

cp -r ./config/* ~/.config/
git checkout .
