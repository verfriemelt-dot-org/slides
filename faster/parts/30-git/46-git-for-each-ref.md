---

# git for-each-ref

> Iterate over all refs that match `<pattern>` and show them according to the given `<format>`, after sorting them according to the given set of `<key>`. If `<count>` is given, stop after showing that many refs. The interpolated values in `<format>` can optionally be quoted as string literals in the specified host language allowing their direct evaluation in that language.

```bash
$ git for-each-ref
e2f5a0786c0bc57269a9b5ec654581fac4624119 commit refs/heads/JIRA-1337/implement-something-nice
e2f5a0786c0bc57269a9b5ec654581fac4624119 commit refs/heads/main
565bee11eac5e4cd68771ff9239b1f2371f255a4 commit refs/remotes/origin/main
75f56e13b0add68ba2c1cfc9b30d1c398978100a commit refs/tags/0.0.1
e2f5a0786c0bc57269a9b5ec654581fac4624119 commit refs/tags/0.0.2

```

. . .

**filter for specific refs**
```
$ git for-each-ref refs/tags
75f56e13b0add68ba2c1cfc9b30d1c398978100a commit refs/tags/0.0.1
e2f5a0786c0bc57269a9b5ec654581fac4624119 commit refs/tags/0.0.2
```

. . .

```bash
$ git for-each-ref refs/heads refs/remotes
e2f5a0786c0bc57269a9b5ec654581fac4624119 commit refs/heads/JIRA-1337/implement-something-nice
565bee11eac5e4cd68771ff9239b1f2371f255a4 commit refs/heads/main
565bee11eac5e4cd68771ff9239b1f2371f255a4 commit refs/remotes/origin/main
```

. . .


use `--format` with `refname` in order to get useful output - no awk required

**refname**
> [...] If lstrip=<N> (rstrip=<N>) is appended, strips <N> slash-separated path components from the front (back) of the refname (e.g. `%(refname:lstrip=2)` turns `refs/tags/foo` into foo and `%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`). If <N> is a negative number, strip as many path components as necessary from the specified end to leave -<N> path components (e.g. `%(refname:lstrip=-2`) turns `refs/tags/foo` into `tags/foo` and `%(refname:rstrip=-1)` turns `refs/tags/foo` into `refs`). When the ref does not have enough components, the result becomes an empty string if stripping with positive <N>, or it becomes the full refname if stripping with negative <N>. Neither is an error.

```
$ git for-each-ref --format '%(refname:lstrip=2)' refs/heads
JIRA-1337/implement-something-nice
main
```
