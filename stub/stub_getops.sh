#!/usr/bin/env bash

# Add a colon before the option to make it run in silent error mode
# Add a colon after the option to require a parameter
# Options w/o colons do not expect parameters

#################
### VARIABLES ###
#################
script_name=$(basename "$0")

#################
### FUNCTIONS ###
#################

error_invalid_option () {
    local script_name=$(basename "$0")
    local option=$1
    echo "Invalid option: -$OPTARG"
    exit 1
}

error_option_required() {
    local script_name=$(basename "$0")
    local passed_option=$1
    echo "Option -$passed_option requires an argument"
    exit 1
}

error_no_arguments() {
    echo "$script_name got no arguments"
    exit 1
}

while getopts ":a:b:" opt; do
    case $opt in
        a)
            # Option a called correctly
            echo "argument -a called with a parameter $OPTARG" >&2
            ;;
        b)
            # Option b called correctly
            echo "argument -b called with a parameter $OPTARG" >&2
            ;;
        \?)
            # Wrong option given. Neither a nor b
            argument=$OPTARG
            error_invalid_option $argument
            ;;
        :)
            # Missing parameter on either argument
            argument=$OPTARG
            error_option_required $argument
            ;;
        "")
            # No arguments given
            echo "no arguments"
            error_no_arguments
            ;;

    esac
done