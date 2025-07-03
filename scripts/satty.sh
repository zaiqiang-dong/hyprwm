#!/usr/bin/env bash

version=$(curl -sL https://api.github.com/repos/gabm/Satty/releases| jq -r ".[0].name")
echo $version
download_url="https://github.com/gabm/Satty/releases/download/"${version}"/satty-x86_64-unknown-linux-gnu.tar.gz"
download_file="satty-x86_64-unknown-linux-gnu.tar.gz"
unzip_dir="satty"

echo $download_url
echo $download_file
echo $unzip_dir

mkdir $unzip_dir
wget $download_url
tar -xvf $download_file -C $unzip_dir
sudo cp ./$unzip_dir/satty /usr/bin/

rm -rf $unzip_dir
rm $download_file
