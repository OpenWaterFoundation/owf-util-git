## Text to be moved ##

The following is used by the experimental diff tool and will be updated
in the future.  The goal is to simplify use of KDiff3.

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
