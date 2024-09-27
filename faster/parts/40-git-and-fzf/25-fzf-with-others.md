---

# fzf + git cherry-pick

```bash
$ git cherry-pick $(git log --oneline --all --reverse | fzf | cut -f1 -d ' ')
```

```bash
$ git merge $(git-branch-picker)
```


