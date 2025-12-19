#!/usr/bin/env bash

git clone git@github.com:pipeseroni/pipes.sh.git
cd pipes.sh
sudo make install
if [ $? -ne 0 ]; then
    cd ..
    rm pipes.sh -rf
    exit 1
fi
cd ..
rm pipes.sh -rf
