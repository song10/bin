#!/bin/sh
cd ~/tmp || exit 1
if [ -d mongoose ]; then
	git pull --rebase
else
	git clone https://github.com/cesanta/mongoose.git
fi

cd mongoose

if [ -d examples/web_server ]; then
	pushd examples/web_server >/dev/null
	make
	mkdir -p ~/opt/bin
	ln -s $(readlink -f ./web_server) ~/opt/bin/mongoose
	popd >/dev/null
elif [ ! -d Build ]; then
	git co 5.1
	mv build Build
	git co master

	pushd Build >/dev/null
	sed -i -e 's/mg_create_server(NULL)/mg_create_server(NULL,NULL)/' main.c
	make
	mkdir -p ~/opt/bin
	ln -s $(readlink -f ./mongoose) ~/opt/bin/mongoose
	popd >/dev/null
fi
