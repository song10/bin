#!/bin/sh
DATA="$(dirname "$0")/.patch_etc_hosts.dat"
if [ -n "$1" ]; then
    DATA="$1"
    shift
fi

if [ ! -f "$DATA" ]; then
    echo "'$DATA' not found! Abort."
    exit 1
fi

sudo sh -c "cat \"$DATA\" >> /etc/hosts"
tail /etc/hosts
