#!/bin/sh
[ -d /mnt/data ] || exit 1

MYDIR=/mnt/data/song10

if [ -d "$MYDIR" ]; then
	sudo mkdir -p "$MYDIR"
	sudo chown $USER.$USER "$MYDIR"
fi

cd $HOME
[ -L my ] || ln -s $MYDIR my
for x in Desktop Documents Downloads Music Pictures Public Templates Videos 'VirtualBox VMs'; do
	[ -d "$MYDIR/$x" ] || mkdir "$MYDIR/$x"
	[ -d "$x" -a ! -L "$x" ] && rmdir "$x"
	[ -e "$x" ] || ln -s "$MYDIR/$x"
done

rm -f examples.desktop

## patch
PDIR='VirtualBox VMs'
if [ -L "$PDIR" ]; then
	rm -f "$PDIR"
	ln -s "$MYDIR/virtualbox" "$PDIR"
fi
