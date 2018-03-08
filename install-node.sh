#!/bin/sh

# nvm needs curl
which curl >/dev/null || sudo apt-get install -y curl

# backup
#
# #curl -s https://raw.github.com/creationix/nvm/master/install.sh | sh
# wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
# [ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM
#

#curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash

NV=v5.2.0
cat << END

open a new terminal and install node.js with following commands:

bash
nvm install $NV

npm install -g typescript
npm install -g typescript-formatter

END
