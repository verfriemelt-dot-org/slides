---

# githook » prepare-commit-msg

```bash
$ head -25 .git/hooks/prepare-commit-msg.sample
#!/bin/sh
#
# An example hook script to prepare the commit log message.
# Called by "git commit" with the name of the file that has the
# commit message, followed by the description of the commit
# message's source.  The hook's purpose is to edit the commit
# message file.  If the hook fails with a non-zero status,
# the commit is aborted.
#
# To enable this hook, rename this file to "prepare-commit-msg".

# This hook includes three examples. The first one removes the
# "# Please enter the commit message..." help message.
#
# The second includes the output of "git diff --name-status -r"
# into the message, just before the "git status" output.  It is
# commented because it doesn't cope with --amend or with squashed
# commits.
#
# The third example adds a Signed-off-by line to the message, that can
# still be edited.  This is rarely a good idea.

COMMIT_MSG_FILE=$1
COMMIT_SOURCE=$2
SHA1=$3

```

---

# githook » prepare-commit-msg

```bash
#!/usr/bin/env bash

_git_repository_root=$( git rev-parse --show-toplevel )
_git_branchname=$( git symbolic-ref -q HEAD )

case $2 in
  "");;                # default commit call
  "message");;         # passed message from commit -m
  "template") exit 0;; # from configured msg template
  "squash")   exit 0;; # squash
  "merge" )   exit 0;; # merge
  "commit" )  exit 0;; # commit ammend or copied message via -c, -C <commitid>
  *)          exit 0;;
esac

if [[ ! -z $tick ]]
then
  sed -i "1s/^/${tick}: /" "$1"
  exit 0
fi

supported_projects=("FOO" "BAR" "JIRA")

exp='('
exp+=$( IFS="|" ; echo "${supported_projects[*]}" )
exp+=')'
exp+="-[0-9]+"

if [[ $_git_branchname =~ $exp ]]
then
  sed -i "1s/^/${BASH_REMATCH[0]}: /" "$1"
  exit 0
fi
```

. . . 


**never forget ticket numbers again**
```bash
$ git checkout -b feature/JIRA-1337-fancy-task
$ git commit -m 'i did something' --allow-empty
[feature/JIRA-1337-fancy-task 563833b] JIRA-1337: i did something

$ git show 
commit 563833b (HEAD -> feature/JIRA-1337-fancy-task)
Author: Richard Heine <rheine@work.org>
Date:   2024-09-27 22:12:01 +0200

    JIRA-1337: i did something
````

. . . 

overwrite with `tick=JIRA-1 git commit -m 'foo'`

```bash 
$ tick=JIRA-1 git commit -m 'i did related to another jira' --allow-empty
[feature/JIRA-1337-fancy-task c27b82a] JIRA-1: i did related to another jira

$ git show
commit c27b82a (HEAD -> feature/JIRA-1337)
Author: Richard Heine <rheine@work.org>
Date:   2024-09-27 22:16:02 +0200

    JIRA-1: i did related to another jira
```
