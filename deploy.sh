#!/usr/bin/env bash


./scripts/worksapce.sh
cp -r ./config/* ~/.config/
git checkout ./config/hypr/workspace.conf
