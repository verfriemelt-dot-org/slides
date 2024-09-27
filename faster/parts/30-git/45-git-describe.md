---

# git describe

> Give an object a human readable name based on an available ref

> The command finds the most recent tag that is reachable from a commit. If the tag points to the commit, then only the tag is shown. Otherwise, it suffixes the tag name with the number of additional commits on top of the tagged object and the abbreviated object name of the most recent commit. The result is a "human-readable" object name which can also be used to identify the commit to other git commands.

```shell
$ git tag 0.0.1 HEAD~2
$ git describe --tags
0.0.1-2-ge2f5a07
```

> By default (without --all or --tags) git describe only shows annotated tags.

. . . 

```
$ git tag 0.0.2
$ git describe --tags
0.0.2
```

useful for container image tagging and versions in footers

```shell
$ git describe --tags > .version
$ docker build . -t service-$(git describe --tags)
```
