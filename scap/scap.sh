#!/usr/bin/env bash

for _pane in $(tmux list-panes -a -F '#{pane_id}') 
	do
  	tmux clear-history -t "${_pane}"
  done