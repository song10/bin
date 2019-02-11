#!/bin/sh
XPATH=$(readlink -f $(dirname "$0"))
FILES=".bash_my_bin .bashrc_alias .bashrc_env .bashrc_path .bashrc_prompt .bashrc_func"
FILES="$FILES .andes-proxy-env .no-andes-proxy-env"
FILES="$FILES .gitconfig .screenrc"
# FILES="$FILES env.v5"
cd $HOME
if [ -z "$1" ]; then
  for x in $FILES; do
    ln -s "$XPATH/rc/$x"
  done
else
  rm -f $FILES
fi
