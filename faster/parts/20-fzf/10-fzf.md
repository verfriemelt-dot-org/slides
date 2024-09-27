---

# fzf

> It's an interactive filter program for any kind of list; files, command history, processes, hostnames, bookmarks, git commits, etc. It implements a "fuzzy" matching algorithm, so you can quickly type in patterns with omitted characters and still get the results you want.

. . . 

if invoked without any arguments or input
```
  faster/parts/30-git/20-conditional-includes.md
  faster/parts/30-git/10-tags.md
  faster/parts/10-patat/00-patat.md
  faster/parts/20-fzf.md
  faster/parts/01-intro.md
  faster/parts/00-header.md
  faster/compile.md
  faster/Makefile
  .idea/workspace.xml
  .idea/vcs.xml
  .idea/slides.iml
  .idea/php.xml
  .idea/modules.xml
  .idea/git_toolbox_blame.xml
  .idea/.gitignore
▌ .gitignore
  16/16 ───────────────────────────────────────────
>
```

. . .

```
▌ faster/parts/30-git/20-conditional-includes.md
  faster/parts/30-git/10-tags.md
  2/16 ───────────────────────────────────────────────────────────
> tags
```

will return
```
$ fzf
faster/parts/30-git/20-conditional-includes.md
$
```

--- 

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
▌ foo-1-baz
  1/3 ────────────────────────────────
>  1z
```

. . .

```shell
$ (echo foo-1-baz; echo foo-2-bar; echo foo-1-wtf) | fzf
foo-1-baz

```
