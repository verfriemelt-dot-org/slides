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
fzf
```

---

---

# fzf

> It's an interactive filter program for any kind of list; files, command history, processes, hostnames, bookmarks, git commits, etc. It implements a "fuzzy" matching algorithm, so you can quickly type in patterns with omitted characters and still get the results you want.

<!--
 * stdin -> fitler -> stdout
 * [n] liste aller dateien im verzeichnis
 * [n] eingabe "tags" fuzzy search, pfeil nach oben, selectiert conditional includes
-->
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

<!--
* input nach fzf pipe
* [n] 3x echo pipen nach stdin

-->

# reading from stdin

```bash
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

```bash
$ (echo foo-1-baz; echo foo-2-bar; echo foo-1-wtf) | fzf
foo-1-baz

```

---

<!--
* viele optionen fzf zu customizen
* manipulieren der optionen (input transformieren zur darstellung)
* tiebreak
* preview an der linken seite
-->

# customizing fzf

```shell
$ fzf --help

    -x, --extended          Extended-search mode
    -e, --exact             Enable Exact-match
    -i, --ignore-case       Case-insensitive match (default: smart-case match)
    --literal               Do not normalize latin script letters before matching
    -n, --nth=N[,..]        Comma-separated list of field index expressions
    -d, --delimiter=STR     Field delimiter regex (default: AWK-style)
    --tail=NUM              Maximum number of items to keep in memory
    --track                 Track the current selection when the result is updated
    --tac                   Reverse the order of the input
    --disabled              Do not perform search
    --tiebreak=CRI[,..]     Comma-separated list of sort criteria to apply
    -m, --multi[=MAX]       Enable multi-select with tab/shift-tab
    --cycle                 Enable cyclic scroll
    --wrap                  Enable line wrap
    [...]
```
