---

# fzf + git cherry-pick

```bash
$ git cherry-pick $(git log --oneline --all --reverse | fzf | cut -f1 -d ' ')
```

# fzf + git merge

```bash
$ git merge $(git-branch-picker)
```

---

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
demo #0
```
