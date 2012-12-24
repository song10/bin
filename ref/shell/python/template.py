#!/usr/bin/env python
import argparse
import subprocess
import string

parser = argparse.ArgumentParser(description='Daily Stuff.')
# parser.add_argument('integers', metavar='N', type=int, nargs='+', help='an integer for the accumulator')
# parser.add_argument('--sum', dest='accumulate', action='store_const', const=sum, default=max, help='sum the integers (default: find the max)')
parser.add_argument('-f', '--force', help='force to do the job')
args = parser.parse_args()

template = string.Template(
"""
if [ '-r' = "$$1" ]; then sed -i '$$d' ~/.payrolltime; fi
$force = xxx
payrolltime && exit
if [ 2 = $$? ]; then opt='-a -f'; fi

title
sudo echo -n # just to ask sudo password
#mygetup $$opt
aptup
gitup
"""
)

script = template.substitute(vars(args))
# print script

template = """
if [ '-r' = "$1" ]; then sed -i '$d' ~/.payrolltime; fi
%(force)s = xxx
payrolltime && exit
if [ 2 = $? ]; then opt='-a -f'; fi

title
sudo echo -n # just to ask sudo password
#mygetup $opt
aptup
gitup
"""

script = template % vars(args)
print script

#subprocess.call(script, shell=True)
