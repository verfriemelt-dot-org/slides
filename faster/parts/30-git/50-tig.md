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
tig
```

---

---

# git - tig

**What is Tig?**

> Tig is an ncurses-based text-mode interface for git. It functions mainly as a Git repository browser, but can also assist in staging changes for commit at chunk level and act as a pager for output from various Git commands.

```
2024-09-27 13:22 +0000 Not Committed Yet o Unstaged changes
2024-09-27 15:21 +0200 ಠ_ಠ               o [main] includes
2024-09-27 15:03 +0200 ಠ_ಠ               o drop faster.md in favor of compile.md
2024-09-27 14:41 +0200 ಠ_ಠ               I init


[main] Unstaged changes                                                                             100%
```

. . .

```
2024-09-27 13:22 +0000 Not Committed Yet o Unstaged │commit e62b21e
2024-09-27 15:21 +0200 ಠ_ಠ               o [main] in│Author:     ಠ_ಠ <easteregg@verfriemelt.org>
2024-09-27 15:03 +0200 ಠ_ಠ               o drop fast│AuthorDate: 2024-09-27 15:03:33 +0200
2024-09-27 14:41 +0200 ಠ_ಠ               I init     │Commit:     ಠ_ಠ <easteregg@verfriemelt.org>
                                                    │CommitDate: 2024-09-27 15:03:33 +0200
                                                    │
                                                    │    drop faster.md in favor of compile.md
                                                    │---
                                                    │ .gitignore                       |   1 +
                                                    │ faster/Makefile                  |   8 +-
                                                    │ faster/faster.md                 | 202 ----------
                                                    │ faster/parts/30-git/10-tags.md   |   1 +
                                                    │ .../20-conditional-includes.md   |  88 ++--
                                                    │ 5 files changed, 71 insertions(+), 229 deletions(-
                                                    │
                                                    │diff --git a/.gitignore b/.gitignore
[main] e62b21e3e60f06f86095a58c96c44dc757f22e51 100%│[diff] e62b21e - line 1 of 365                   4%
```

. . .

`tig blame $filename`
```
75f56e1 ಠ_ಠ 2024-09-27 14:41 +0200   1│ # git - conditional includes
75f56e1 ಠ_ಠ 2024-09-27 14:41 +0200   2│
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200   3│ **~/.gitconfig**
75f56e1 ಠ_ಠ 2024-09-27 14:41 +0200   4│ ```bash
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200   5│ [include]
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200   6│   path = ~/.config/git/generic
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200   7│
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200   8│ [includeIf "gitdir:~/src/work/"]
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200   9│   path = ~/.config/git/work
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200  10│
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200  11│ [includeIf "gitdir:~/src/private/"]
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200  12│   path = ~/.config/git/private
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200  13│ ```
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200  14│
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200  15│ . . .
e62b21e ಠ_ಠ 2024-09-27 15:03 +0200  16│
[blame] faster/parts/30-git/20-conditional-includes.md - line 7 of 79                                20%
```
