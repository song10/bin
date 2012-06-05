#!/bin/sh
#rem maure.mooo.com
fn=/tmp/ppp0ip
ip=$(ifconfig ppp0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')
if test ! -e /tmp/pppip; then touch $fn; fi
oldip=$(tail -n1 $fn)

if test "$oldip" = "$ip"; then
  echo ppp0 keep $ip
else
  echo ppp0 up $ip
  echo $ip > $fn
  wget -O - -q --read-timeout=0.0 --waitretry=5 --tries=400 --background http://freedns.afraid.org/dynamic/update.php?VDRiMlBxMzFVMVVBQUlOR0tVNDo3NzMxMDYy > /dev/null
fi
