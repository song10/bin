#!/usr/bin/env python3
import os
import sys
from string import Template

title = None
type = []

# parse argv
for arg in sys.argv[1:]:
    if len(arg) > 0 and arg[0] == '-':
        type.append(arg)
    else:
        title = arg

# default title
if title == None:
    title = os.uname()[1]
# print('a "%s"' % title)

# default type
if len(type) == 0:
    term = os.environ.get('TERM', '')
    sty = os.environ.get('STY', '')
    typ = '-t' if term != 'screen' and sty == '' else '-s'
    type.append(typ)
# print(type)

# normalize title
if len(title):
    path = os.getcwd()
    if title == '.':
        title = os.path.basename(path)
        if title == '':
            title = os.sep
    elif title == '..':
        title = os.path.relpath(path, '%s/../..' % path)
        if title == '.':
            title = os.sep
        elif not os.sep in title:
            title = os.sep + title
# print(title)

# normalize type
std_type = []
for typ in type:
    for x in typ:
        if x == '-': continue
        std_type.append(x)
# print(std_type)

# generate shell script
script = ':'
for typ in std_type:
    if typ == 't':
        # for GNOME Terminal
        template = r'''
;PROMPT_COMMAND='echo -ne "\033]0;$title\007"'
'''
        d = dict(title=title)
        t = Template(template)
        script += t.substitute(d)[1:-1]
    elif typ == 's':
        # for GNU screen
        template = r'''
;PROMPT_COMMAND='echo -ne "\033k$title\033\\"'
'''
        d = dict(title=title)
        t = Template(template)
        script += t.substitute(d)[1:-1]
    else:
        script += ';echo "type \'%s\' not supported!"' % typ

# done
print(script)
