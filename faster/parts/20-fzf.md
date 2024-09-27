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
