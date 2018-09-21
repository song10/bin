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

# read config
import json
cfg_file = os.path.join(py_path, 'config.json')
with open(cfg_file) as fh:
    jsn = json.load(fh)
    cfg = Structure(**jsn)

# load database
import importlib
modname = 'data.{}.envrc'.format(cfg.context)
env = importlib.import_module(modname).env

# render scripts
import sys
script = ''
if len(sys.argv) < 2:
    print('nothing to do, abort!')
    exit(1)

for x in sys.argv[1:]:
    if hasattr(env, x):
        script += getattr(env, x)

# done
print(script)
