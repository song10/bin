sudo apt-get install -y git
cd ~
if [ ! -d .git ]; then
	git init
	git remote add origin ~/Dropbox/repo/my/ubhome.git/
	git fetch
	git checkout -b master origin/master
else
	git stash
	git pull --rebase
	git stash pop
fi

if [ ! -d bin/ ]; then
	git clone ~/Dropbox/repo/my/bin.git/
else
	cd bin/
	git stash
	git pull --rebase
	git stash pop
fi

if [ ! -d ~/wrk/ubfavor/ ]; then
	cd ~/wrk/
	git clone ~/Dropbox/repo/my/ubfavor.git/
else
	cd ~/wrk/ubfavor/
	git stash
	git pull --rebase
	git stash pop
fi

if [ ! -d ~/wrk/xman/ ]; then
	cd ~/wrk/
	git clone ~/Dropbox/repo/my/xman.git/
else
	cd ~/wrk/xman/
	git stash
	git pull --rebase
	git stash pop
fi

