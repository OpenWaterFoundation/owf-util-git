# build-util #

This folder contains useful Git utilities.
A `build-util` folder can be created in a repository to contain utility scripts.
The `git-util` sub-folder contains useful general Git utility scripts,
which can be called by a specific script as demonstrated in this repo.

The following are the customized scripts that are included in this folder:

* `git-check-util.sh` - specific implementation that calls `git-util/git-check.sh`
* `git-clone-all-util.sh` - specific implementation that calls `git-util/git-clone-all.sh`
* `git-tag-all-util.sh` - specific implementation that calls `git-util/git-tag-all.sh`

The following are the general utility scripts in the `git-util` folder
called by the customized scripts:

* `git-check.sh` - check the list of product repositories for status,
whether need to push, pull, etc.
* `git-clone-all.sh` - clone all repositories related to the product,
which is useful when setting up a new product that involves multiple repositories
* `git-tag-all.sh` - tag all repositories related to the product,
which is useful when tagging multiple repositories related to a product
