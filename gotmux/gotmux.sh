#!/bin/bash

# A script to start tmux in a desired state

#################
### VARIABLES ###
#################

laptop="operations"
lxd="containers"
pyenv="pyenv"

############
### MAIN ###
############

# Start a tmux server
tmux start-server

# Start operations session with 3 windows
# Session for python virtual environments
tmux new-session -d -s $laptop
tmux new-window -t $laptop:0 -n COMMANDS:system

tmux select-window -t $laptop:1
tmux rename-window -t bash COMMANDS:installations

# lxd session
tmux new-session -d -s $lxd
tmux new-window -t $lxd:0 -n COMMANDS:lxd/lxc
tmux select-window -t $lxd:0
tmux send-keys "lxc list" C-m

tmux select-window -t $lxd:1
tmux rename-window -t bash SERVER:VM:example
# tmux send-keys "ssh someserver" C-m

# Session for python virtual environments
tmux new-session -d -s $pyenv
tmux new-window -t $pyenv:0 -n EXECUTE:jrnl
tmux select-window -t $pyenv:0
tmux send-keys "source $HOME/.virtualenvs/jrnl/bin/activate" C-m

tmux select-window -t $pyenv:1
tmux rename-window -t bash PYENV:aws
tmux send-keys "source $HOME/.virtualenvs/aws/bin/activate" C-m

tmux new-window -t $pyenv:2
tmux select-window -t $pyenv:2
tmux rename-window -t bash PYENV:devops
tmux send-keys "source $HOME/.virtualenvs/devops/bin/activate" C-m

tmux new-window -t $pyenv:3
tmux select-window -t $pyenv:3
tmux rename-window -t bash PYENV:terraform
tmux send-keys "source $HOME/.virtualenvs/terraform/bin/activate" C-m

tmux new-window -t $pyenv:4
tmux select-window -t $pyenv:4
tmux rename-window -t bash PYENV:ansible
tmux send-keys "source $HOME/.virtualenvs/ansible/bin/activate" C-m

# Go back to the first window of the operations session and attach
tmux select-window -t $session:0
tmux attach -d -t $laptop