# build-util #

This folder contains useful Git utilities.
A `build-util` folder can be created in a repository to contain utility scripts.
The `git-util` sub-folder contains useful general Git utility scripts,
which can be called by a specific script as demonstrated in this repo.

The following are the customized scripts that are included in this folder:

* `git-clone-all-util.sh` - specific implementation of `git-util/git-clone-all.sh`
* `git-check-util.sh` - specific implementation of `git-util/git-check.sh`

The following are the general utility scripts in the `git-util` folder
called by the customized scripts:

* `git-check.sh` - check the list of product repositories for status,
whether need to push, pull, etc.
* `git-cline-all.sh` - clone all repositories related to the product,
useful setting up a new product that involves multiple repositories
