#!/bin/bash -xe

# Allow the docker container id or name as a param
CONTAINER="$1"

# What to do if no container info is given
if [[ "$CONTAINER" == "" ]]; then
	echo "Container name or id required"
	exit 1
fi

# Start an interactive shell on the given container
# Depending on the container, the shell command might need editing
# alpine, for example uses ash, or sh
docker exec -i -t $CONTAINER ash

