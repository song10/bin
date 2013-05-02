#!/bin/bash
usage(){
	cat <<EOF
Usage:
	`basename $0` [options]
EOF
	exit
}

cmd=$1
case $cmd in
	'0'|'site')
		xcd site
		title .
		smount ubs64
		smount util
		;;
	'1'|'app')
		xcd app
		title .
		bin/update
		;;
	'2'|'mongoose')
		xcd eino
		title mongoose
		mongoose
		;;
	'3'|'jade')
		xcd eino
		title jade
		jade -w *.jade
		;;
	'4'|'stylus')
		xcd eino
		cd css
		title .
		stylus -w *.styl
		;;
	'5'|'prj')
		xcd eino
		cd2
		title .
		;;
	'6'|'eclipse')
		xcd app
		cd dnl/eclipse
		title .
		;;
	*)
		echo "Unknown option '$cmd'!"
		usage
esac
