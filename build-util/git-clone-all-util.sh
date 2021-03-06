#!/bin/sh
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required
# The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL
#
# git-clone-all-util - clone all Git utility repositories for new development environment setup
# - this script calls the general git utilities script
# - this script is not really needed because in order to get started, the single repo must be cloned
# - it is used to illustrate how the utilities would be implemented in another software project

# Get the location where this script is located since it may have been run from any folder
scriptFolder=`cd $(dirname "$0") && pwd`

# Git utilities folder is relative to the user's files in a standard development files location
# - determine based on location relative to the script folder
# Specific repository folder for this repository
repoHome=`dirname ${scriptFolder}`
# Want the parent folder to the specific Git repository folder
gitReposHome=`dirname ${repoHome}`

# Git utilities GitHub repo URL root
githubRootUrl="https://github.com/OpenWaterFoundation"

# Main Git utilities repository
mainRepo="owf-util-git"

# Run the generic utility script
${scriptFolder}/git-util/git-clone-all.sh -m "${mainRepo}" -g "${gitReposHome}" -u "${githubRootUrl}" $@
