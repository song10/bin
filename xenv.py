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
with open(cfg_file) as cfg:
    jsn = json.load(cfg)
    data = Structure(**jsn)

# get or set
import sys
while len(sys.argv) > 1:
    if data.context == sys.argv[1]:
        break

    data.context = sys.argv[1]
    jsn = vars(data)
    # write config
    with open(cfg_file, 'w') as config:
        json.dump(jsn, config)
    break

pp.pprint(vars(data))
