#!/bin/sh
sudo sed -i '/deb http:\/\/download.virtualbox.org\/virtualbox\/debian saucy contrib/d' /etc/apt/sources.list
echo 'deb http://download.virtualbox.org/virtualbox/debian saucy contrib' | sudo tee -a /etc/apt/sources.list
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y virtualbox-4.3 dkms
