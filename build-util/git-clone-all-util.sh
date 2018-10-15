#!/bin/sh
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required
# The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL
#
# git-clone-all-util - clone all Git utility repositories for new development environment setup
# - this script calls the general git utilities script
# - this script is not really needed because in order to get started, the single repo must be cloned
# - it is used to illustrate how the utilities would be implemented in another software project

# Get the location where this script is located since it may have been run from any folder
# -see: https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
# -see: https://gist.github.com/tvlooy/cbfbdb111a4ebad8b93e
# -the following should work if no symbolic links are involved, but no link should be used here so use the simple solution
scriptDir=`dirname "$0"`

# Git utility product home is relative to the user's files in a standard development files location
# - $HOME/${productHome}
productHome="owf-dev/Util-Git"

# Git utilities GitHub repo URL root
githubRootUrl="https://github.com/OpenWaterFoundation"

# Main Git utilities repository
mainRepo="owf-util-git"

# Run the generic utility script
${scriptDir}/git-util/git-clone-all.sh -m "${mainRepo}" -p "${productHome}" -g "${githubRootUrl}" $@
