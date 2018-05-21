#TOC

1. fbg: Script to change the background image on fluxbox
2. updaterepos: Script to pull the latest master branch for each repo in a directory of repos
3. getrecipes: Script to pull all of the recipes used by a chef node
4. check_managed.sh: Script to tell if a node is managed by chef or not
5. delswap: Script to remove bash swap files, recursively, from the current directory
6. search.sh: Script serves a a wrapper to the command find . -name 'string' -print
7. json2yaml: Script to convert a json file to yaml and vice versca
8. extractpem.sh: Wrapper script for the ssh-keygen process that extracts a pubkey from a pem file

1. fbg
 REQUIREMENTS:
  POSIX-compliant shell
  coreutils, sed, shuf, find
 USE:
  fbg /path/to/directory/of/images
  example: fbg /home/myuser/.fluxbox/backgrounds
 DESCRIPTION:
  Script will search the given directory, count the number of files, pick one of those files to be the background images for fluxbox
 WARNINGS:
  The script does not currently discriminate between images and other types of files. fbsetbg will fail if the chosen file is not an image
 TODO:
  Rewrite the glob used in the find command to only search for extensions associated with image types
  Rewrite the image selection so that it excludes non-image type files
  Add a getopts and make the script use the current directory if no directory is given
  Add several checks to ensure the required programs (sed, shuf, etc) are installed before the script can execute

2. updaterepos
    REQUIREMENTS:
        POSIX-compliant shell
        git (apt-get install git...or equivalent for yum)
        Proper ssh key set up with your repository host whether that's github, gitlab, self-hosted or whatever
    USE:
        updaterepos full-path-of-repo-directory
        example updaterepos /home/tthompson/build/repos/company
    DESCRIPTION:
        Script will list all of the files in the given directory and attempt to cd into those listings and run a git pull origin master to retrieve the latest information for the repo
    WARNINGS:
        Script does not currently test to see if the file listing is in fact a directory and does check to make sure that the directory is actually a git repo. It simply grabs the listing and tries to run the command
    TODO:
        Add a test that fails if a listing isn't a directory
        Add a test that fails if a directory is not a git repository
        Add checks to make sure git is properly installed and configured
        Add something to let a person choose which repository host to use

3. getrecipes
    REQUIREMENTS:
        POSIX-compliant shell
        check_managed.sh must be in your path
        getrecipes must be in your path
        Properly configured chef environment (keys and whatnot) and properly installed knife tools. Installing ChefDK for you system should take care of these
    USE:
        getrecipes name-of-some-chef-node
        example: getrecipes prod-nginx-server-oak
    DESCRIPTION:
        Script will take the given node name, check to see if it is managed by chef, and if it is, use knife to display all of the recipes used by that node
    TODO:
        Add a test that fails if check_managed.sh is not installed


4. check_managed.sh
    REQUIREMENTS:
        POSIX-compliant shell
        Must be added to your PATH environment variable
        Properly configured chef environment (keys and whatnot) and properly installed knife tools. Installing ChefDK for you system should take care of these
    USE:
        check_managed.sh chef-node
        example: check_managed.sh prod-nginx-server-oak
    DESCRIPTION:
        Script will take the given node and check it against chef. It will print a 0 if the node is managed by chef and a 1 if the node is not managed by chef
    WARNINGS:
        Script is used by getrecipes. So if you intend to use getrecipes you will need this script as well.

5. delswap
    REQUIREMENTS:
        POSIX-compliant shell
        Must be placed somewhere in your PATH
        Must be executable
    USE:
        delswap (that's it. No arguments required)
    DESCRIPTION:
        Script will take the current working directory from pwd and recursively search it for bash swap files .sw[*]. For each one it finds it will delete it. That's it
    WARNINGS:
        There are no prompts or confirmations whatsoever. As long as the user that executes the script has permissions the found files will be deleted. Be sure not to run it anywhere sensitive.

6. search.sh
    REQUIREMENTS
        POSIX-compliant shell
        Must be placed somewhere in your PATH
        Must be executable
    USE: search.sh somestring
    DESCRIPTION:
        Script will take the first argument as a search string and run a find command in the current directory for that string. Script will error out if no string is given
    TODO:
        Need to add some provisions for large output sets (i.e) run the find results through xargs for processing

7. jsonyaml
    REQUIREMENTS
        POSIX-compliant shell
        Must be placed somewhere in your PATH
        Must be executable
        Must have a working python 2.7 environemnt (most modern systems come with this)
    USE: 
        json to yaml: jc filename.json
        yaml to json: yc filename.yaml
    DESCRIPTION:
        The jc script takes a json file and converts it to yaml. Currently the file must have a .json extension
        The yc script takes a yaml file and converts it to json. Currently the file must have a .yml extension
    TODO:
        Need to add some functionality for ensuring that an argument is given on the command line
        Need to determine whether or not a file extension is part of the argument passed to the script and behave appropriately

8. extractpem
  REQUIREMENTS
    POSIX-compliant shell
    Must be placed somewhere in your PATH
    Must be executable
    Must have ssh-keygen installed ( installing openssh will take care of this one)
  USE:
    extractpem -k name_of_pemfile -p [ /path/to/pem/file]
    -p is optional. If it is not given, the script defaults to $HOME/.ssh
    The script errors out if:
      1. No option is given
      2. An option other than -k or -p is given
      3. The argument for either option does not exist (i.e. an invalid pem file name or directory)
      4. The openssh package, which contains ssh-keygen is not installed
