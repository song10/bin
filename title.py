#!/usr/bin/env python3
import os
import sys
from string import Template

# term_type
# -x for xterm
# -s for screen
# -t for tmux
#
title = None
term_type = []

# parse argv
for arg in sys.argv[1:]:
    if len(arg) > 0 and arg[0] == '-':
        term_type.append(arg)
    else:
        title = arg

# default title
if title == None:
    title = os.uname()[1]
# print('a "%s"' % title)

# default term_type
if len(term_type) == 0:
    # term = os.environ.get('TERM')
    sty = os.environ.get('STY')
    tmux = os.environ.get('TMUX')
    typ = '-s' if sty else '-t' if tmux else '-x'
    term_type.append(typ)
# print(term_type)

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

# normalize term_type
std_type = []
for typ in term_type:
    for x in typ:
        if x == '-': continue
        std_type.append(x)
# print(std_type)

# generate shell script
script = ''
for typ in std_type:
    if typ == 'x':
        # for xterm
        template = r'''PROMPT_COMMAND='echo -ne "\033]0;$title\007"';'''
        d = dict(title=title)
        t = Template(template)
        script += t.substitute(d)
    elif typ == 's':
        # for screen
        template = r'''PROMPT_COMMAND='echo -ne "\033k$title\033\\"';'''
        d = dict(title=title)
        t = Template(template)
        script += t.substitute(d)
    elif typ == 't':
        # for tmux
        template = r'''tmux rename-window '$title';'''
        d = dict(title=title)
        t = Template(template)
        script += t.substitute(d)
    else:
        script += 'echo "term_type \'%s\' not supported!";' % typ

# done
print(script)
