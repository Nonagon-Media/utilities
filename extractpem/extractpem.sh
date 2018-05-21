#!/bin/bash

# File to extract the pubkey from a pem file

#################
### VARIABLES ###
#################

KEYNAME=''
KEYPATH="$HOME/.ssh"

#################
### FUNCTIONS ###
#################

# Function to display proper usage of the script
usage() {
  SCRIPTNAME=$(basename "$0")
  echo "Usage:"
  echo "$SCRIPTNAME -k [-p /path/to/key]"
  echo "-k is the name of the pem file"
  echo "-p is the path to the pem file (if not $HOME/.ssh)"
  exit 1
}

# Function to extract the pub key from a pem file
extract_key() {
  # First make a name for the new pub key
  TMPNAME=${KEYNAME::-4}
  PUBKEYNAME="$TMPNAME.pub"

  # Now extract the pub key from the pem file and name it
  ssh-keygen -y -f "$KEYPATH"/"$KEYNAME" > "$KEYPATH"/"$PUBKEYNAME"

  # See if that worked
  exitCode="$?"
  if [ ! $exitCode -eq 0 ]; then
    echo "Pubkey generation failed for $KEYPATH/$KEYNAME"a
  else
    echo "Pubkey $PUBKEYNAME was created in the directory $KEYPATH"
  fi
}
############
### MAIN ###
############

# Process options
while getopts ":k:p:" opt; do
  case $opt in
  k)    KEYNAME="$OPTARG"
        ;;
  p)    KEYPATH="$OPTARG"
        ;;
  :)    echo "Option -$OPTARG requires an argument" >&2
        usage
        ;;
  \?)   echo "Invalid options: -$OPTARG" >&2
        usage
        ;;
  *)    echo "Either invalid option or the option is missing an argument"
        usage
        ;;
  esac
done

# Make sure the directory is real and the pem file we're looking for is in there
if [ -d $KEYPATH ]; then
  echo "Directory: $KEYPATH exists"
  if [ -f $KEYPATH/$KEYNAME ]; then
    echo "File $KEYNAME exists."
    # Call the extract function
    extract_key
  else
    echo "The pem file $KEYNAME does not exist in $KEYPATH"
    usage
  fi
else
  echo "The directory $KEYPATH does not exist"
  usage
fi
