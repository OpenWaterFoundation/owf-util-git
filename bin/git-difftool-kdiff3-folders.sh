#!/bin/sh
#
# Use KDiff3 to interactively view differences between two Git commits/branches.

# Check the KDiff3 configuration
checkConfig () {
	# Check that the configuration settings are defined.
	difftool_kdiff3_path=`git config --list | grep difftool.kdiff3.path | cut -d = -f 2`
	difftool_kdiff3_cmd=`git config --list | grep difftool.kdiff3.cmd | cut -d = -f 2`
	echo "Git config difftool.kdiff3.path=${difftool_kdiff3_path}"
	echo "Git config difftool.kdiff3.cmd=${difftool_kdiff3_cmd}"
	hasErrors=false
	# Require the path to be set mainly so a check for program existence can occur
	if [ "${difftool_kdiff3_path}" == "" ]
		then
		echo "Git global configuration property needs to be set in ~/.gitconfig:  difftool.kdiff3.path"
		hasErrors=true
	#else
		# Check that the kdiff3 executable is found
		# TODO smalers 2017-11-28 deal with this later, not working due to backslash?
		#if [ ! -e "${difftool_kdiff3_path}" ]
		#	then
		#	echo "KDiff3 executable is not found:  ${difftool_kdiff3_path}"
		#	hasErrors=true
		#else
		#	if [ ! -x "${difftool_kdiff3_path}" ]
		#		then
		#		echo "KDiff3 program is not executable:  ${difftool_kdiff3_path}"
		#		hasErrors=true
		#	fi
		#fi 
	fi
	if [ "${difftool_kdiff3_cmd}" == "" ]
		then
		echo "Git global configuration property needs to be set in ~/.gitconfig:  difftool.kdiff3.cmd"
		hasErrors=true
	fi
	# Exit if any configuration is bad
	if [ "${hasErrors}" == "true" ]
		then
		echo "Must fix configuration before using utility."
		exit 1
	fi
}

# Print script usage
printUsage () {
	echo ""
	echo "Usage:  git-difftool-kdiff3-folders.sh commit1 commit2"
	echo "        git-difftool-kdiff3-folders.sh branch1 branch2"
	echo ""
	exit 0
}

# Run the utility
runUtil () {
	commit1=$1
	commit2=$2
	echo "Running:  git difftool --dir-diff --tool=kdiff3 ${commit1} ${commit2}"
	echo "KDiff3 user interface will appear..."
	git difftool --dir-diff --tool=kdiff3 ${commmit1} ${commit2}
	exitStatus=$?
	echo "KDiff3 exit status is ${exitStatus}"
	exit ${exitStatus}
}

# Start of the main logic

# First check the configuration
checkConfig

# Parse command parameters, brute force
if [ $# -ne 2 ]
	then
	printUsage
else
	commit1=$1
	commit2=$2
fi

# Now run the utility script
runUtil ${commit1} ${commit2}

exit 0
