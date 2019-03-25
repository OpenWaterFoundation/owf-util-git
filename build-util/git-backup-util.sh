#!/bin/sh
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required
# The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL
#
# git-backup-util - help backup a list of Git repositories by cloning all to a folder
# - this script calls the general git utilities script

# Get the location where this script is located since it may have been run from any folder
scriptFolder=`cd $(dirname "$0") && pwd`

# Git utilities folder is relative to the user's files in a standard development files location
# - determine based on location relative to the script folder
# Specific repository folder for this repository
repoHome=`dirname ${scriptFolder}`

# Repository list to back up
backupRepoListFile="$scriptFolder/backup-repo-list.txt"

# Output folder
# - use the current date, but could overwrite the main folder
today=$(date --iso-8601=date)
outputFolder="$scriptFolder/backups/$today"

# Now run the general script using full path
${scriptFolder}/git-util/git-backup.sh -l ${backupRepoListFile} -o ${outputFolder} $@
