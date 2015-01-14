#!/bin/sh
VER=${1:-3.13.0-41}
sudo apt-get -y remove \
	linux-image-${VER}-generic \
	linux-image-extra-${VER}-generic \
  linux-signed-image-${VER}-generic