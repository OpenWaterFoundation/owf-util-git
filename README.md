# owf-util-git #

This repository contains Open Water Foundation Git utilities.
These are scripts that help use Git, intended to work in Linux, Cygwin, and Git Bash.
These utilities are being developed to facilitate using Git,
especially more complex Git command usage.
The scripts also check for configuration to help avoid errors.

## Repository Contents ##

The following folder structure is used for the repository:

```text
.gitattributes                       Git repository configuration file.
.gitignore                           Git configuration file for files to ignore.
doc/                                 Markdown files with helpful documentation.
bin/                                 Folder for Git utility shell scripts.
  git-difftool-kdiff3-folders.sh     Use KDiff3 to "diff" two folders from commits/branches.

```

## Installing Utilities and PATH Configuration ##

The utilities can be installed in several ways:

1. Clone the repository and then add the `bin` folder to the `PATH`.
2. Clone the repository and then copy the scripts in the repository `bin` folder to a suitable folder that is in the `PATH`.
3. Download individual scripts from the repository `bin` folder and install into a suitable folder that is in the `PATH`.

Script names are long to avoid ambiguity.  It is expected that command completion is enabled to help.
If an abbreviated name is desired, define a shell alias or rename the script when installing.

### Cygwin ###

Add something like the following to the `$HOME/.bash_profile` to enable finding scripts in the repository `bin` folder.
The `$USERNAME` Windows environment variable is recognized by Cygwin and indicates the user's login name (and home folder).
The folder used to clone the repository is a user preference.

``` text
# Set PATH so it includes the Git utilities
if [ -d "/cygdrive/C/Users/$USERNAME/owf-dev/Util-Git/git-repos/owf-util-git/bin" ] ; then
  PATH="/cygdrive/C/Users/$USERNAME/owf-dev/Util-Git/git-repos/owf-util-git/bin:${PATH}"
fi

```

### Git Bash ###

Add something like the following to the `$HOME/.bash_profile` to enable finding scripts in the repository `bin` folder.
The `$USERNAME` Windows environment variable is recognized by Git Bash and indicates the user's login name (and home folder).
The folder used to clone the repository is a user preference.

``` text
# Set PATH so it includes the Git utilities
if [ -d "/C/Users/$USERNAME/owf-dev/Util-Git/git-repos/owf-util-git/bin" ] ; then
  PATH="/C/Users/$USERNAME/owf-dev/Util-Git/git-repos/owf-util-git/bin:${PATH}"
fi

```

### Linux ###

To be added...

## Git Configuration for Utilities ##

Some utility scripts require Git configuration properties, as described below.

### Cygwin ###

```text
# Configuration to allow KDiff3 program to be used with 'git difftool' command
# - KDiff3 is installed on Windows (not within Cygwin)
[difftool "kdiff3"]
        path = /cygdrive/C/Program\\ Files/KDiff3/kdiff3.exe
        cmd = /cygdrive/C/Program\\ Files/KDiff3/kdiff3.exe \"$(cygpath -wla $LOCAL)\" \"$(cygpath -wla $REMOTE)\"
```

### Git Bash ###

```text
# Configuration to allow KDiff3 program to be used with 'git difftool' command
# - KDiff3 is installed on Windows (not within Cygwin)
[difftool "kdiff3"]
        path = /C/Program\\ Files/KDiff3/kdiff3.exe
        cmd = /C/Program\\ Files/KDiff3/kdiff3.exe \"$(cygpath -wla $LOCAL)\" \"$(cygpath -wla $REMOTE)\"
```

### Linux ###

To be added...
