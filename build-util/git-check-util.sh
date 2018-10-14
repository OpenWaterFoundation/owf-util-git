#!/bin/sh
#
# git-check-util - check the Git utilities repositories for status
# - this script calls the general git utilities script

# Git utilities product home is relative to the user's files in a standard development files location
# - $HOME/${productHome}
productHome="owf-dev/Util-Git"

# Main repository
mainRepo="owf-util-git"

# TODO smalers 2018-10-12 The following may need to be made absolute to run from any folder
git-util/git-check.sh -m "${mainRepo}" -p "${productHome}" $@
