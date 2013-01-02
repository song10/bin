#!/bin/sh
xcd.pl $* > /tmp/x && . /tmp/x
return $?

R=~/bin

_lookup () {
	for x in `cat $R/xcd.db`; do
		key=$(echo $x | cut -d':' -f1)
		if test "$key" = "$1"; then
			val=$(echo $x | cut -d':' -f2)
			val=$(eval "echo $val")
			cd $val
			return 0
		fi
	done
	return 1
}

if test 0 -eq $#; then
	cd -
else
	_lookup $1
	if test 0 -ne $? ; then
		echo -n "define '$1' : "
		read def
		echo "$1:$def" >> $R/xcd.db

		_lookup $1
	fi
fi
