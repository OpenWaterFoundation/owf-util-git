#!/bin/sh
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required
# The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL
#
#-----------------------------------------------------------------NoticeStart-
# Git Utilities
# Copyright 2017-2019 Open Water Foundation.
# 
# License GPLv3+:  GNU GPL version 3 or later
# 
# There is ABSOLUTELY NO WARRANTY; for details see the
# "Disclaimer of Warranty" section of the GPLv3 license in the LICENSE file.
# This is free software: you are free to change and redistribute it
# under the conditions of the GPLv3 license in the LICENSE file.
#-----------------------------------------------------------------NoticeEnd---
#
# git-backup.sh
#
# Clone all repositories to a backup folder
# - the folder can then be backed up
# - the script may be enhanced in the future to create tar.gz or otherwise facilitate backups

# Supporting functions, alphabetized

# Determine the operating system that is running the script
# - mainly care whether Cygwin
checkOperatingSystem()
{
	if [ ! -z "${operatingSystem}" ]; then
		# Have already checked operating system so return
		return
	fi
	operatingSystem="unknown"
	os=`uname | tr [a-z] [A-Z]`
	case "${os}" in
		CYGWIN*)
			operatingSystem="cygwin"
			;;
		LINUX*)
			operatingSystem="linux"
			;;
		MINGW*)
			operatingSystem="mingw"
			;;
	esac
	#echo "operatingSystem=$operatingSystem (used to check for Cygwin and filemode compatibility)"
}

# Parse the command parameters
parseCommandLine() {
	local OPTIND l h o v
	optstring=":hl:o:v"
	while getopts $optstring opt; do
		#echo "Command line option is ${opt}"
		case $opt in
			h) # -h  Print usage
				printUsage
				exit 0
				;;
			l) # -l backupRepoListFile  File containing URLs to Git repositories
				backupRepoListFile=$OPTARG
				;;
			o) # -o outputFolder  Specify the output folder where repos will be cloned
				outputFolder=$OPTARG
				;;
			v) # -v  Print the version
				printVersion
				exit 0
				;;
			\?)
				echo "Invalid option:  -$OPTARG" >&2
				exit 1
				;;
			:)
				echo "Option -$OPTARG requires an argument" >&2
				exit 1
				;;
		esac
	done
}

# Print the script usage
printUsage() {
	scriptName=$(basename $0)
	echo ""
	echo "Usage:  scriptName -l backupRepoListFile -o outputFolder"
	echo ""
	echo "Clone all repositories into a backup folder to copy elsewhere or write to media."
	echo ""
	echo "Example:"
	echo "    $scripName -l repo-list.txt -o backups/2019-03-24"
	echo ""
	echo "-h print the usage"
	echo "-l specify the repository list file (list of URLs)"
	echo "-o specify the backup output folder"
	echo "-v print the version"
	echo ""
}

# Print the script version
printVersion() {
	scriptName=$(basename $0)
	echo ""
	echo "$scriptName version ${version}"
	echo ""
	echo "Git Utilities"
	echo "Copyright 2019 Open Water Foundation."
	echo ""
	echo "License GPLv3+:  GNU GPL version 3 or later"
	echo ""
	echo "There is ABSOLUTELY NO WARRANTY; for details see the"
	echo "'Disclaimer of Warranty' section of the GPLv3 license in the LICENSE file."
	echo "This is free software: you are free to change and redistribute it"
	echo "under the conditions of the GPLv3 license in the LICENSE file."
	echo ""
}

# Main script entry point

# Variables
dryRun=false # Default is to run operationally
#dryRun=true  # for testing

version="1.0.0 2019-03-25"

backupRepoListFile=""
outputFolder=""

# Check the operating system to control logic
checkOperatingSystem

# Parse the command line
parseCommandLine "$@"

echo ""
echo "Backup repository list file = $backupRepoListFile"
echo "Output folder = $outputFolder"
echo ""

# Check input
if [ ! -f "${backupRepoListFile}" ]; then
	echo ""
	echo "The backup repository list file ($backupRepoListFile) does not exit."
	printUsage
	exit 1
fi

# Check that backup folder is specified
if [ -z "${outputFolder}" ]; then
	echo ""
	echo "The output folder has not been specified."
	printUsage
	exit 1
fi

# Check for backup folder existence
# - create if it does not exist

if [ -d "${outputFolder}" ]; then
	# Output folder already exists.  Remove its contents
	while [ "1" = "1" ]
	do
		echo ""
		echo "The backup output folder ($outputFolder) exists."
		read -p "Remove its contents [y/n]?: " answer
		if [ "${answer}" = "y" ]
		then
			# Want to continue
			break
		else
			# Don't want to continue
			exit 0
		fi
	done
	# Remove the folder contents
	rm -rf "$outputFolder"/*
else
	echo ""
	echo "Backup folder does not exist, creating:  ${outputFolder}"
	echo ""
	mkdir -p "$outputFolder"
	if [ "$?" -ne "0" ]; then
		echo ""
		echo "Error creating output folder $outputFolder"
	fi
fi

# Change to the output folder
cd "${outputFolder}"
# Clone each repository in the repository list
while IFS= read -r repoUrl
do
	# Make sure there are no carriage returns in the string
	# - can happen because file may have Windows-like endings but Git Bash is Linux-like
	# - use sed because it is more likely to be installed than dos2unix
	repoUrl=`echo ${repoUrl} | sed 's/\r$//'`
	if [ -z "${repoUrl}" ]
	then
		# Blank line
		continue
	fi
	firstChar=`expr substr "${repoUrl}" 1 1` 
	if [ "${firstChar}" = "#" ]
	then
		# Comment line
		continue
	fi
	# Clone the repo
	echo "================================================================================"
	echo "Cloning repository:  ${repoUrl}"
	if [ ${dryRun} = "true" ]
	then
		echo "Dry run:  cloning repository with:  git clone \"${repoUrl}\""
	else
		git clone ${repoUrl}
	fi
done < ${backupRepoListFile}
echo "================================================================================"

# List the repositories

echo ""
echo "After cloning, ${outputFolder} contains:"
ls -1 ${outputFolder}
