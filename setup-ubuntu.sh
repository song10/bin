#!/bin/sh
[ "/bin/dash" = $(readlink -f /bin/sh) ] && sudo dpkg-reconfigure dash

sudo apt-get install -y git tig vim meld curl

cd
[ -d .git ] || curl -s https://raw.github.com/song10/ubstart/master/setup.sh | sh

HDIR=/mnt/data/song10
[ -d $HDIR ] || exit 1
rm -f examples.desktop
for x in Desktop Documents Downloads Music Pictures Public Templates Videos; do
	rmdir $x
	[ -d $HDIR/$x ] || mkdir -p $HDIR/$x
	ln -s $HDIR/$x
done
