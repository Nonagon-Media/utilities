#!/bin/bash

FILE=/usr/bin/docker
# Remove all stopped containers
if [ -f "$FILE" ]; then
	docker rm $(docker ps -a -q)
else
	echo "Docker executable not located at $FILE"
fi
