---

<!--config:
margins:
  left: auto
  right: auto
  top: auto
theme:
  codeBlock: [ vividGreen ]
-->

```figlet
git
```

---

# git - tags sorting

```shell
$ git tag 4.10.0
fatal: tag '4.10.0' already exists
```

. . . 

```bash
$ git tag
4.1.0
4.10.0
4.11.0
4.2.0
4.3.0
4.4.0
4.5.0
4.6.0
4.7.0
4.8.0
4.9.0
```

. . .

```bash
$ git config --global tag.sort version:refname
$ git tag
4.8.1
4.8.2
4.8.3
4.8.4
4.9.0
4.10.0
4.11.0
```
