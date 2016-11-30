#!/bin/bash

# Description goes here
# A little wrapper around the find command
# Testing something

#################
### VARIABLES ###
#################

# GLOBALS
SCRIPTNAME=`basename "$0"`

# Search params
TARGET_DIR=`pwd`
TARGET_STRING=""

# MESSAGES
MSG_NO_SEARCH_PATTERN="No search string was given to $SCRIPTNAME"


#####################
### END VARIABLES ###
#####################

#################
### FUNCTIONS ###
#################

# Function to error out if no search pattern was given
func_err_no_search_pattern() {
  echo "$MSG_NO_SEARCH_PATTERN"
  echo "Try: $SCRIPTNAME somestring"
  exit 1
}

# Function to search for a string in the current directory
func_search_string() {
  # Parse arguments
  LOCAL_TARGET_DIR=$1
  LOCAL_TARGET_STRING=$2

  # Perform the search
  find $LOCAL_TARGET_DIR -name "*$LOCAL_TARGET_STRING*" -print

}


#####################
### END FUNCTIONS ###
#####################

############
### MAIN ###
############

# Check to see that a string to search for was given
if [ -z "$1" ];
    then
        func_err_no_search_pattern
    else
    TARGET_STRING=$1
fi

# func_err_no_search_pattern will exit the script if condition is met
# so if that function doesn't run, it's okay to do the search
func_search_string $TARGET_DIR $TARGET_STRING

