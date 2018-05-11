#!/usr/bin/env python3
import os
import sys
from string import Template

# for GNOME Terminal
template = r'''
PROMPT_COMMAND='echo -ne "\033]0;$title\007"'
'''

# generate shell script
title = sys.argv[1] if len(sys.argv) > 1 else os.path.basename(os.getcwd())
d = dict(title=title)
t = Template(template)
script = t.substitute(d)[1:-1]
# print('script', script)

# done
print(script)
