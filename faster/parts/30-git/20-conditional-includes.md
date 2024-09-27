---

# git - conditional includes

**~/.gitconfig**
```shell
[include]
  path = ~/.config/git/generic

[includeIf "gitdir:~/src/work/"]
  path = ~/.config/git/work

[includeIf "gitdir:~/src/private/"]
  path = ~/.config/git/private
```

. . . 

**~/.config/git/generic**
```
[init]
  defaultBranch = main
[core]
  hooksPath = ~/.githooks
  abbrev = 7
  pager = less -F -X -I
[rerere]
  enabled = true
  autoupdate = true
[push]
  default = current
[pull]
  rebase = true
  default = current
[tig "color"]
  cursor = default blue
```

. . .

**~/.config/git/private**
```
[user]
  email = easteregg@verfriemelt.org
  name = ಠ_ಠ
```

. . .

**~/.config/git/work**
```
[user]
  email = rheine@work.org
  name = Richard Heine
[core]
    sshCommand = ssh -i ~/.ssh/id_rsa.work
    excludesfile = ~/.config/git/work.gitignore
```

---

# git - conditional includes


commit in repository in `/src/privat`
```
commit 75f56e1 (HEAD -> main)
Author: ಠ_ಠ <easteregg@verfriemelt.org>
Date:   2024-09-27 23:41:07 +0200
```

commit in repository in `/src/work`
```
commit 75f56e1 (HEAD -> main)
Author: Richard Heine <rheine@work.org>
Date:   2024-09-27 08:35:01 +0200
```
