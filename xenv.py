#!/usr/bin/env python3


class Structure:
    def __init__(self, **entries):
        self.__dict__.update(entries)


# helpers
import pprint
pp = pprint.PrettyPrinter(indent=4)

# get script path
import os
py_path = os.path.dirname(os.path.realpath(__file__))

# default context
cfg = Structure(**{'context': 'local'})

# read config
import json
cfg_file = os.path.join(py_path, 'config.json')
with open(cfg_file) as fh:
    jsn = json.load(fh)
    cfg = Structure(**jsn) # update with file

# get or set
import sys
# print('Argument List:', str(sys.argv), len(sys.argv))
while True:
    len = len(sys.argv)
    if len <= 1:  # get context
        cfg.context = os.environ.get('XENV', cfg.context)
        break

    cfg.context = sys.argv[1]
    if len <= 2: # temporary change
        break

    # permanent change
    jsn = vars(cfg)
    with open(cfg_file, 'w') as config:
        json.dump(jsn, config) # write config
    break

# pp.pprint(vars(cfg))
with open('/tmp/xenv', 'w') as script:
    script.write('''
export XENV="%s"
echo "XENV = $XENV"
''' % cfg.context)
    print('. /tmp/xenv')
