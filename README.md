# owf-util-git #

This repository contains Open Water Foundation (OWF) Git utilities.
These are scripts that help use Git, intended to work in Linux, Cygwin,
and particularly Git Bash.
These utilities encapsulate Git commands that can be complex to use,
and help automate tasks when a product involves multiple Git repositories
and Git commands.
The scripts also check for configuration issues to help avoid errors.

* [Repository Contents](#repository-contents)
* [`bin` Utilities - Installing and Configurating the `PATH`](#bin-utilities-installing-and-configuring-the-path)
* [`bin` Utilities - Git Configuration](#bin-utilities-git-configuration)
* [`build-util` Utilities](#build-util-utilities)
* [License](#license)
* [Contributing](#contributing)

-----

## Repository Contents ##

The following folder structure is used for the repository:

```text
.gitattributes                       Git repository configuration file.
.gitignore                           Git configuration file for files to ignore.
bin/                                 Folder for Git utility shell scripts,
                                     intended to work with any repository.
  git-difftool-kdiff3-folders.sh     Use KDiff3 to "diff" two folders from commits/branches.
build-util/                          Folder for scripts that would be installed
                                     in a build-util folder in a repository.

```

## `bin` Utilities - Installing and Configurating the `PATH` ##

The `bin` utilities can be installed in several ways:

1. Clone the repository and then add the `bin` folder to the `PATH`.
2. Clone the repository and then copy the scripts in the repository `bin` folder to a suitable folder that is in the `PATH`.
3. Download individual scripts from the repository `bin` folder and install into a suitable folder that is in the `PATH`.

Script names are long to avoid ambiguity.
It is expected that command completion is enabled to help.
If an abbreviated name is desired, define a shell alias or rename the script when installing.

### Cygwin ###

It is assumed that repositories will be cloned in the Windows user files (`/cygdrive/C/Users`),
rather than Cygwin user files (`/home`).
Add something like the following to the `$HOME/.bash_profile` to enable finding scripts in the repository `bin` folder.
The `$USERNAME` Windows environment variable is recognized by Cygwin and indicates the user's login name (and home folder).
The folder used to clone the repository is a user preference.
If editing from Windows rather than command line, the file is typically located under `C:\Users\username`.

``` text
# Set PATH so it includes the Git utilities
if [ -d "/cygdrive/C/Users/$USERNAME/owf-dev/Util-Git/git-repos/owf-util-git/bin" ] ; then
  PATH="/cygdrive/C/Users/$USERNAME/owf-dev/Util-Git/git-repos/owf-util-git/bin:${PATH}"
fi

```

### Git Bash ###

Add something like the following to the `$HOME/.bash_profile` to enable finding scripts in the repository `bin` folder.
The `$HOME` Windows environment variable is recognized by Git Bash and indicates the user's login name (and home folder).
The folder used to clone the repository is a user preference.
If editing from Windows rather than Bash command line, the file is typically located under `C:\Users\username`.

``` text
# Set PATH so it includes the Git utilities
if [ -d "$HOME/owf-dev/Util-Git/git-repos/owf-util-git/bin" ] ; then
  PATH="$HOME/owf-dev/Util-Git/git-repos/owf-util-git/bin:${PATH}"
fi

```

### Linux ###

Add something like the following to the `$HOME/.bash_profile` to enable finding scripts in the repository `bin` folder.
The `$HOME` Windows environment variable is recognized by Git Bash and indicates the user's login name (and home folder).
The folder used to clone the repository is a user preference.

``` text
# Set PATH so it includes the Git utilities
if [ -d "$HOME/owf-dev/Util-Git/git-repos/owf-util-git/bin" ] ; then
  PATH="$HOME/owf-dev/Util-Git/git-repos/owf-util-git/bin:${PATH}"
fi

```

## `bin` Utilities - Git Configuration ##

Some utility scripts require Git configuration properties, as described below.

### Cygwin ###

The name of a user's Git configuration file can be determined using `git --list --show-origin`,
in which case the file containing a Git configuration property is shown on the left side of output.

The configuration file can be edited from a Cygwin terminal window command line
using file location `~/.gitconfig` (`$HOME/.gitconfig).
If editing from Windows, the location is `C:\Users\username\.gitconfig`.

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
        cmd = /C/Program\\ Files/KDiff3/kdiff3.exe \"$LOCAL\" \"$REMOTE\"
```

### Linux ###

To be added...

## `build-util` Utilities ##

The Git utilities located in the `build-util` folder are intended to be
copied to the main repository for a product.
These utilities are particularly useful when multiple repositories
comprise the full product.
The utility scripts have been developed and tested in Git Bash.  Utilities are:

* `git-clone-all` - after cloning the main repository for a product,
this script will clone all other repositories needed for product development
* `git-check` - check the status of all repositories for a product command
and indicate which ones needed to be pushed, pulled, committed, etc.

To use these utilities:

1. Determine the product's main repository.
This is typically the repository for the source code of the main program.
Other repositories in a product may include tests, documentation,
libraries, etc.
2. In the main repository working files,
create a `build-util` folder, if not already created.
3. Under `build-util`, create a `git-util` folder.
4. Copy desired Git utility scripts from the `build-util/git-util` folder of
this repository to the folder created in step 3.
These scripts should not need to be modified.
5. In the `build-util` folder created in step 2,
create scripts that are specific to the product's main repository.
See examples in the `build-util` folder of this repository.
6. Also in the `build-util` folder, create a file `product-repo-list.txt`
containing the list of repository names for the product.
See the [example `product-repo-list.txt` file in this repository](build-util/product-repo-list.txt).

The resulting folder structure will be similar to the following,
where the leading path folders will vary by user.

```
/UserHome/                         User's home folder.
  DevFiles/                        Development files, separate from user's other files.
    SomeProduct/                   The development files for a product.
      git-repos/                   Folder to hold all Git repositories for a product.
        repo-name-main/            The first repository for the product - main repo.
          build-util/              Development/build Utilities.
            git-check-prod.sh      git-check.sh wrapper for specific product.
            git-util/              General Git utilities (copy from this repo).
            product-repo-list.txt  List of repositories, used by Git utilities.
        repo-name-2/               The second repository for the product - a component.
        etc./                      Other repository folders for the product.
```

## License ##

The OWF Git Utilities are licensed under the GPL v3+ license.
See the [GPL v3 license text](LICENSE.md).

Because the utilities will be used by developers of a product,
this mainly means that developers need to have access to the scripts,
which will be the case anyhow.

## Contributing ##

These Git utilities have been developed by the Open Water Foundation to
help its staff and collaborators be effective and efficient with Git and GitHub.
Contributions are welcome.
