#!/usr/bin/env python3

import sys
from config import config as cfg 
# print(cfg.context)

import pprint
pp = pprint.PrettyPrinter(indent=4)


# determin key to lookup
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
template = Template('mkdir -p $path;cd $path;title $title')
script = template.substitute(d)
# print('script', script)

# done
print(script)
