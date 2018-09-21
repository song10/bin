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

# determin key to lookup
import sys
if len(sys.argv) < 2:
    print('nowhere to go, abort!')
    exit(1)
key = sys.argv[1]
# print('key', key)

# convert key to path
path = key
import os
if '.' == key[0]:
    path = os.path.abspath(key)
else:
    # load database
    dbname = sys.argv[0][:-2] + 'db'
    lst = dbname.split('/')
    lst.insert(-1, 'data/{}'.format(cfg.context))
    dbname = '/'.join(lst)
    # print('dbname', dbname)
    dbfh = open(dbname, 'r+')
    db = {}
    for line in dbfh:
        (k, v) = line.strip().split(':')
        db[k] = v
    # pp.pprint(db)

    # lookup now
    if key in db:
        # found
        path = db[key]
    else:
        # new
        path = input("define '{}' : ".format(key))
        dbfh.write("{}:{}\n".format(key, path))
    dbfh.close()
# print('path', path)

# generate shell script
from string import Template
title = '/'.join(path.split('/')[-2:])
d = dict(path=path, title=title)
template = Template('mkdir -p $path;cd $path;title $title;[ -e .xcd.rc ] && . .xcd.rc')
script = template.substitute(d)
# print('script', script)

# done
print(script)
