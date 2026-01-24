#!/usr/bin/env bash

git clone https://github.com/google/re2
cd re2
make
sudo make install

if [ $? -ne 0 ]; then
    cd ..
    rm -rf re2
    exit 1
fi
cd ..
rm -rf re2
