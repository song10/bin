#!/bin/sh
[ -d /mnt/data ] || exit 1

MYDIR=/mnt/data/song10
sudo mkdir -p $MYDIR
sudo chown $USER.$USER $MYDIR
cd $HOME
ln -s $MYDIR my
rm -f examples.desktop
for x in Desktop Documents Downloads Music Pictures Public Templates Videos 'VirtualBox VMs'; do
  [ -d "$x" ] || mkdir -p "$x"
  mv $x $MYDIR
  ln -s $MYDIR/$x
done
