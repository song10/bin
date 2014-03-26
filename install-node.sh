#!/bin/sh
which curl >/dev/null || sudo apt-get install -y curl
curl -s https://raw.github.com/creationix/nvm/master/install.sh | sh
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM
NV=0.11.11
nvm install $NV
nvm alias default $NV
nvm use default
