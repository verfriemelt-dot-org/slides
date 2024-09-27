---

# fzf & git for-each-ref » check 'dis out!

**give me branches**

```shell
$ git branch something lame
```

```shell
$ git for-each-ref --format '%(refname:lstrip=2)' refs/heads
JIRA-1337/implement-something-nice
main
```

**filter with fzf**

```
  main
  JIRA-1337/implement-something-lame
▌ JIRA-1337/implement-something-nice
  3/3 ───────────────────────────────
>
```

. . . 

**sort it better**

```shell
$ git for-each-ref --format '%(refname:lstrip=2)' refs/heads | \
    awk '{ print length(), $0 | "sort -n" }' | \
    cut -d ' ' -f2-
main
JIRA-1337/implement-something-lame
JIRA-1337/implement-something-nice
```

this looks off, but `fzf` will take input in reverse order, so we want the shortest branchname at the top

```
$ (echo a; echo b; echo c;) | fzf
  c
  b
▌ a
  3/3 ────────
```

```
$ git for-each-ref --format '%(refname:lstrip=2)' refs/heads | \
    awk '{ print length(), $0 | "sort -n" }' | \
    cut -d ' ' -f2- | \
    fzf
  JIRA-1337/implement-something-nice
  JIRA-1337/implement-something-lame
▌ main
  3/3 ─────────────────────────────────────────────────────────
>

```


. . .

but remote branches are missing. so we need to get them too

```shell
$ git fetch --all
From github.com:verfriemelt-dot-org/slides
* [new branch]      JIRA-31337/something-even-nicer -> origin/JIRA-31337/something-even-nicer
```

after fetching we can get all refs in `refs/remote` and `refs/heads`
```
$ git for-each-ref --format '%(refname:lstrip=2)' refs/heads refs/remotes
JIRA-1337/implement-something-lame
JIRA-1337/implement-something-nice
main
origin/JIRA-31337/something-even-nicer
origin/main
```

. . .

**but checking checking out branches which start with `origin/` does not yield the desired result**
```shell
$ git checkout origin/JIRA-31337/something-even-nicer
Note: switching to 'origin/JIRA-31337/something-even-nicer'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.
```

. . .

so we must get rid of the `origin/` prefix for that
```shell
$ ( git for-each-ref --format '%(refname:lstrip=2)' refs/heads; \
git for-each-ref --format '%(refname:lstrip=3)' refs/remotes/origin ) | \
    awk '{ print length(), $0 | "sort -n" }' | \
    cut -d ' ' -f2- | \
    fzf
main
main
JIRA-31337/something-even-nicer
JIRA-1337/implement-something-lame
JIRA-1337/implement-something-nice
```

add in `uniq` to get rid of branches already present in `refs/heads`

```shell
$ ( git for-each-ref --format '%(refname:lstrip=2)' refs/heads; \
    git for-each-ref --format '%(refname:lstrip=3)' refs/remotes/origin ) | \
    awk '{ print length(), $0 | "sort -n" }' | uniq | \
    cut -d ' ' -f2- | \
    fzf
  JIRA-1337/implement-something-nice
  JIRA-1337/implement-something-lame
  JIRA-31337/something-even-nicer
▌ main
  4/4 ──────────────────────────────────
>
```

. . .

combine that with `git checkout` and _magic_

```shell
$ git checkout $(( git for-each-ref --format '%(refname:lstrip=2)' refs/heads; \
git for-each-ref --format '%(refname:lstrip=3)' refs/remotes/origin ) | \
awk '{ print length(), $0 | "sort -n" }' | uniq | \
cut -d ' ' -f2- | \
fzf)
branch 'JIRA-31337/something-even-nicer' set up to track 'origin/JIRA-31337/something-even-nicer'.
Switched to a new branch 'JIRA-31337/something-even-nicer'
```
