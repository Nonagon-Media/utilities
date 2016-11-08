#!/bin/bash

#################
### VARIABLES ###
#################

# MESSAGES
NO_SERVER_GIVEN="Server name is required"
SERVER_IS_MANAGED="is managed by chef"
SERVER_NOT_MANAGED="is not managed by chef"

# GLOBAL ARRAYS
declare -a node_list=()

#####################
### END VARIABLES ###
#####################

#################
### FUNCTIONS ###
#################

# Function to error out if no argument given on command line
func_no_server() {
  echo "$NO_SERVER_GIVEN"
  echo "Try something like check_managed.sh server-name.telmate.cc"
  exit 1
}

# Function to generate an array containing a list of chef-managed servers
func_generate_node_list() {
  for node in $( knife node list );
    do
      node_list+=("$node")
    done
}

# Function to compare a server against the chef node list
func_check_server() {

  # Store server name locally
  local_target_server=$1

  # Check server against contents of the array
  if [[ "${node_list[*]}" =~ "${local_target_server}" ]]
    then
      func_server_managed $local_target_server
    else
      func_server_unmanaged $local_target_server
  fi

}

# Function to inform user that server is managed
func_server_managed() {
  local_managed_server=$1
  #echo "$local_managed_server $SERVER_IS_MANAGED"
  echo "0"
  exit 0
}

# Function to inform user that server is not managed
func_server_unmanaged() {
  local_unmanaged_server=$1
  #echo "$local_unmanaged_server $SERVER_NOT_MANAGED"
  echo "1"
  exit 0
}
#####################
### END FUNCTIONS ###
#####################

############
### MAIN ###
############

# Ensure that an argument was given
if [[ -z $1 ]]
  then
    func_no_server
  else
    target_server=$1
fi

func_generate_node_list
func_check_server $target_server
