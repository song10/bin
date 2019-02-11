#!/bin/sh
FILES=".bashrc_alias .bashrc_env .bashrc_path .bashrc_prompt .bashrc_func"
FILES="$FILES .andes-proxy-env .no-andes-proxy-env"
FILES="$FILES .gitconfig .screenrc"
# FILES="$FILES env.v5"
cd $HOME
if [ -z "$1" ]; then
  for x in $FILES; do
    ln -s ~/my/bin/rc/$x
  done
else
  rm -f $FILES
fi
