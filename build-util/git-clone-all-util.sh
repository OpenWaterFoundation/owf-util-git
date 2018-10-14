#!/bin/sh
#
# git-clone-all-util - clone all Git utility repositories for new development environment setup
# - this script calls the general git utilities script
# - this script is not really needed because in order to get started, the single repo must be cloned
# - it is used to illustrate how the utilities would be implemented in another software project

# Git utility product home is relative to the user's files in a standard development files location
# - $HOME/${productHome}
productHome="owf-dev/Util-Git"

# Git utilities GitHub repo URL root
githubRootUrl="https://github.com/OpenWaterFoundation"

# Main Git utilities repository
mainRepo="owf-util-git"

# TODO smalers 2018-10-12 The following may need to be made absolute to run from any folder
# - also pass the command parameters so that -h, etc. are recognized
git-util/git-clone-all.sh -m "${mainRepo}" -p "${productHome}" -g "${githubRootUrl}" $@
