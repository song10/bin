#!/bin/sh

# install pre-required packages
PREPKG=
which curl >/dev/null || PREPKG="$PREPKG curl"
which java >/dev/null || PREPKG="$PREPKG default-jdk"
[ -n "$PREPKG" ] && sudo apt-get install -y $PREPKG

# do it
cd ~/Downloads
curl -s -O -C - http://eclipse.stu.edu.tw/technology/epp/downloads/release/kepler/SR1/eclipse-cpp-kepler-SR1-linux-gtk-x86_64.tar.gz

mkdir -p ~/opt
cd ~/opt
if [ -d eclipse ]; then
	echo `pwd`/eclipse/ existed\!
else
	tar xf ~/Downloads/eclipse-cpp-kepler-SR1-linux-gtk-x86_64.tar.gz
fi

cd ~/.local/share/applications
if [ -f eclipse.desktop ]; then
	EXEPATH=$(readlink -f ~/opt/eclipse/eclipse)
	sed -i -e "s|Exec=.\+|Exec=env UBUNTU_MENUPROXY=0 $EXEPATH|" eclipse.desktop
else
	echo lock eclipse launcher and re-run $(basename $0) again.
	cd
	~/opt/eclipse/eclipse
	# exec $0
fi
