---

# fzf & git for-each-ref » check 'dis out!

> give me branches

```shell
$ git for-each-ref --format '%(refname:lstrip=2)' refs/heads
JIRA-1337/implement-something-nice
main
```

but remote branches are missing. so we need to get them too

```
$ git fetch --all
From github.com:verfriemelt-dot-org/slides
* [new branch]      JIRA-31337/something-even-nicer -> origin/JIRA-31337/something-even-nicer
$ git for-each-ref --format '%(refname:lstrip=2)' refs/remotes/origin/
origin/JIRA-31337/something-even-nicer
origin/main
```

