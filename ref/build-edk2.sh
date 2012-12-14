if [[ $_ = $0 ]]; then
	echo -e "#Usage:\n\tsource $0"
	exit
else
	#echo no
	#return
	:
fi

RELPATH=`dirname ${BASH_SOURCE[@]}`

# Install required software from apt
sudo apt-get install -y \
	build-essential \
	uuid-dev texinfo \
	bison \
	flex \
	libgmp3-dev \
	libmpfr-dev \
	subversion \
	expect

# Common instructions for UNIX-like systems
mkdir -p ~/src
cd ~/src

if [ ! -d edk2 ]; then
	#svn co https://edk2.svn.sourceforge.net/svnroot/edk2/trunk/edk2 --username guest
	svn co -r 13997 https://edk2.svn.sourceforge.net/svnroot/edk2/trunk/edk2 --username guest
fi

if [ ! -f edk2/BaseTools/Source/C/bin/GenFw ]; then
	make -C edk2/BaseTools
fi

# Build gcc x64 UEFI cross compiler
if [ ! -e ~/programs/gcc/x64/bin -a -d ~/src/edk2/BaseTools/gcc ]; then
	cd ~/src/edk2/BaseTools/gcc
	patch -p1 < $RELPATH/patch/0001-fix-broken-link.patch
	#./mingw-gcc-build.py --arch=x64 --prefix=~/programs/gcc/x64
	expect -c "spawn ./mingw-gcc-build.py --arch=x64 --prefix=~/programs/gcc/x64; expect \".*(default = no):\"; send \"y\n\";expect \"ld gcc [done]\";"
fi

# Setup build shell environment
cd ~/src/edk2
export EDK_TOOLS_PATH=~/src/edk2/BaseTools
if [ ! -e ~/src/edk2/Conf/target.txt ]; then
  . edksetup.sh BaseTools
		patch -p1 < $RELPATH/patch/0002-fix-Conf.patch
		patch -p1 < $RELPATH/patch/0003-fix-build-warnings.patch
		patch -p1 < $RELPATH/patch/0004-fix-link-issue.patch
else
. edksetup.sh BaseTools
fi

# Build AppPkg
build -p AppPkg/AppPkg.dsc

# done
