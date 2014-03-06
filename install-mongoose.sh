#!/bin/sh
cd ~/tmp || exit 1
if [ -d mongoose ]; then
	git pull --rebase
else
	git clone https://github.com/cesanta/mongoose.git
fi

cd mongoose
if [ ! -d Build ]; then
	git co 5.1
	mv build Build
	git co master
fi

cd Build
sed -i -e 's/mg_create_server(NULL)/mg_create_server(NULL,NULL)/' main.c
make
mkdir -p ~/my/opt/bin
cp mongoose ~/my/opt/bin
