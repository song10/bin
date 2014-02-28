#!/bin/sh
curl -s https://raw.github.com/creationix/nvm/master/install.sh | sh
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM
nvm install v0.10.26
nvm use v0.10.26
