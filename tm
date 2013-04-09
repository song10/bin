#!/bin/bash
SESSION=$HOSTNAME
tmux="tmux -2 -f $HOME/.tmux.conf"

# if the session is already running, just attach to it.
$tmux has-session -t $SESSION
if [ $? -eq 0 ]; then
	echo "Session $SESSION already exists. Attaching."
	sleep 1
	$tmux attach -t $SESSION
	exit 0;
fi

# create a new session, named $SESSION, and detach from it
$tmux new-session -d -s $SESSION
$tmux new-window    -t $SESSION:0 'scr'
$tmux new-window    -t $SESSION:1 -n ubs64 "xssh ubs64"
$tmux new-window    -t $SESSION:2 -n util  "xssh util"
$tmux new-window    -t $SESSION:3
$tmux select-window -t $SESSION:0
$tmux attach -t $SESSION
