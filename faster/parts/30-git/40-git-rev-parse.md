---

# git rev-parse 

. . .

> git-rev-parse - Pick out and massage parameters

. . . 

# So You Think You Know Git - FOSDEM 2024

https://www.youtube.com/watch?v=aolI_Rz0ZqY

. . . 

```bash
$ git rev-parse HEAD
04bdae471848b34890a219699c1ad5105f2de279
```

. . . 

```bash
$  git rev-parse --short HEAD
04bdae4
```

. . .

```bash
$ cd $(mktemp -d)
$ git rev-parse --is-inside-work-tree
fatal: not a git repository (or any parent up to mount point /)

$ git init .
Initialized empty Git repository in /tmp/tmp.7lKOFtTB5X/.git/

$ git rev-parse --is-inside-work-tree
true
```

. . . 

**in scripts**

```sh
git rev-parse --is-inside-work-tree 2>&1 >/dev/null

if [ $? -ne 0 ]
then
    echo 'not a git repository'
    exit 1
fi
```

. . .

# git rev-parse --show-toplevel

```
$ cd /example
$ git init .
$ mkdir foo/bar/what -p && cd foo/bar/what 
$ git rev-parse --show-toplevel
/example
```
