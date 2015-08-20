#TOC

1. fbg: Script to change the background image on fluxbox

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
