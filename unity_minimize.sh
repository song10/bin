#!/bin/sh
# gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true/false
ANS=true
if [ -n "$1" ]; then ANS="$1"; fi
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window ${ANS}
