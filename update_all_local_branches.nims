#!/usr/bin/env -S nim --hints:off
import pegs
import strutils
import strformat
import os

proc exec(cmd: string): int =
  let (_, ec) = gorgeEx(cmd)
  let rz = if ec == 0: "OK" else: "NG"
  echo &"> {cmd} # {rz}"
  return ec

const outp = staticExec "git branch"
let lines = outp.splitLines()
var branches: seq[string]
for l in lines:
    # if l.strip =~ peg"{\ident} '/' {\w (\w / \d / [.-])+}": # brr
    if l.strip =~ peg"('*' \s+)? {\w (\w / \d / [.-])+}": # br
        branches.add(matches[0])

for b in branches:
  if exec(&"git co {b}") == 0:
    if exec(&"git pull") != 0:
      discard
