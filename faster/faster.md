---
title: faster » random things to gain velocity
author: Richard Heine
patat:
  incrementalLists: false
  wrap: true
  margins:
    left: 4
    right: 10
    top: 3
  #  transition:
  #    type: slideLeft
  #    frameRate: 30
  theme:
    emph: [ bold,vividRed ]
    strong: [ bold ]
    underline: [ underline ]
    codeBlock: [ vividGreen,onRgb#101010 ]
    header: [ vividYellow ]
    syntaxHighlighting:
      keyword: [ vividRed ]
  eval:
    figlet:
      command: figlet
      fragment: false
      replace: true
    bash-exec:
      command: bash -e 
      fragment: false
      replace: true
...
---


```figlet
faster !!!
```

. . .

random things to get there

---

# Tools:

* patat + CRT = <3
* zsh
* git
* find
* fzf
* entr
* githooks

---

# patat

```markdown
---
title: example
author: Richard Heine
patat:
    margins:
        left: 4
    transition:
        type: slide
...
---

# slide 1

---

# slide 2
```

--- 

# fzf

> It's an interactive filter program for any kind of list; files, command history, processes,
> hostnames, bookmarks, git commits, etc. It implements a "fuzzy" matching algorithm, 
> so you can quickly type in patterns with omitted characters and still get 
> the results you want.

. . . 

```shell
$ (echo foo-1-baz; echo foo-2-bar; echo foo-1-wtf) | fzf
```

. . . 


```
  foo-1-wtf
  foo-2-bar
▌ foo-1-baz
  3/3 ────────────────────────────────
>

```

. . .

```
  foo-1-wtf
▌ foo-1-baz
  2/3 ────────────────────────────────
>  1

```

. . .

```
▌ foo-1-baz
  1/3 ────────────────────────────────
>  1 z
```

. . .

```shell
$ (echo foo-1-baz; echo foo-2-bar; echo foo-1-wtf) | fzf
foo-1-baz

```

---

# git - tags

```shell
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

```shell
$ git config --global tag.sort version:refname
```

```shell
$ git tag
4.8.1
4.8.2
4.8.3
4.8.4
4.9.0
4.10.0
4.11.0
```


# git - configuration

```shell
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

```shell
$ git config --global tag.sort version:refname
```

```shell
$ git tag
4.8.1
4.8.2
4.8.3
4.8.4
4.9.0
4.10.0
4.11.0
```


