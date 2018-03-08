#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for x in `ls *.m4a`
do
  echo "$x"
  extension="${x##*.}"
  filename="${x%.*}"
  echo $extension
  echo $filename
  avconv -i "$x" "$filename.mp3"
done
IFS=$SAVEIFS
