#!/bin/sh
which add-apt-repository >/dev/null || sudo apt-get install -y python-software-properties
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get -y install git
