#!/bin/sh
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required
# The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL
#
# git-tag-all-util - tag all Git utility repositories for new development environment setup
# - this script calls the general git utilities script
# - it is used to illustrate how the utilities would be implemented in another software project

# Get the location where this script is located since it may have been run from any folder
scriptFolder=`cd $(dirname "$0") && pwd`

# Git utilities folder is relative to the user's files in a standard development files location
# - determine based on location relative to the script folder
# Specific repository folder for this repository
repoHome=$(dirname ${scriptFolder})
# Want the parent folder to the specific Git repository folder
gitReposHome=$(dirname ${repoHome})

# Determine the version from the software product
# - this is used as information to help the user specify an intelligent tag name and commit message
# - for example purposes, use the version from the git-util/git-tag-all.sh script, which has format:
#   version="1.0.0 2018-12-27"
productVersion=$(cat $scriptFolder/git-util/git-tag-all.sh | grep 'version=' | tr -d '"' | cut -d '=' -f 2 | cut -d " " -f 1)
productName="GitUtil"

# Main Git utilities repository
mainRepo="owf-util-git"

# Run the generic utility script
${scriptFolder}/git-util/git-tag-all.sh -m "${mainRepo}" -g "${gitReposHome}" -N "$productName" -V "$productVersion" $@
