#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE=$SCRIPT_DIR/../config/hypr/workspace.conf

monitor_master=""
monitor_sub=""
monitor_count=0

for dev in /sys/class/drm/*/status; do
    if [[ $(cat $dev) == "connected" ]]; then
        name=$(basename $(dirname $dev) | cut -d'-' -f2-)
        let monitor_count=monitor_count+1
        if [[ monitor_count -eq 1 ]]; then
            monitor_master=$name
        else
            monitor_sub=$name
        fi
    fi
done
# echo $monitor_count
# echo $monitor_master
# echo $monitor_sub

if [[ $monitor_count -eq 1 ]]; then
    echo "workspace = 1,  monitor:$monitor_master" >$CONFIG_FILE
    echo "workspace = 2,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 3,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 4,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 5,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 6,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 7,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 8,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 9,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 10, monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 11, monitor:$monitor_master" >>$CONFIG_FILE
else
    echo "workspace = 1,  monitor:$monitor_master" >$CONFIG_FILE
    echo "workspace = 2,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 3,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 4,  monitor:$monitor_master" >>$CONFIG_FILE
    echo "workspace = 5,  monitor:$monitor_master" >>$CONFIG_FILE

    echo "workspace = 6,  monitor:$monitor_sub" >>$CONFIG_FILE
    echo "workspace = 7,  monitor:$monitor_sub" >>$CONFIG_FILE
    echo "workspace = 8,  monitor:$monitor_sub" >>$CONFIG_FILE
    echo "workspace = 9,  monitor:$monitor_sub" >>$CONFIG_FILE
    echo "workspace = 10, monitor:$monitor_sub" >>$CONFIG_FILE
    echo "workspace = 11, monitor:$monitor_sub" >>$CONFIG_FILE
fi
