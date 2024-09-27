---

# git rev-parse 

> git-rev-parse - Pick out and massage parameters

```shell
$  git rev-parse HEAD
04bdae471848b34890a219699c1ad5105f2de279
```

. . . 

```shell
$  git rev-parse --short HEAD
04bdae4
```

. . .

```shell
$ cd $(mktemp -d)
$ git rev-parse --is-inside-work-tree
fatal: not a git repository (or any parent up to mount point /)

$ git init .
Initialized empty Git repository in /tmp/tmp.7lKOFtTB5X/.git/

$ git rev-parse --is-inside-work-tree
true
```

**in scripts**

```sh
git rev-parse --is-inside-work-tree 2>&1 >/dev/null

if [ $? -ne 0 ]
then
    echo 'not a git repository'
    exit 1
fi
```
