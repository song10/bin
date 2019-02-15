#!/bin/sh
cmd="$1"
shift
$cmd "$@" >| /tmp/x && . /tmp/x
