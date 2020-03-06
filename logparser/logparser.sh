#!/bin/bash

logfile="$1"
current_date=$(date +%b\ %d)
for log in $logfile
	do
		egrep "$current_date" $log
	done