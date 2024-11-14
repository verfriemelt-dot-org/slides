---

<!--
* config basierend auf dem aktuellen verzeichnis
* config basierend auf dem aktuellen branch
* config basierend auf dem aktuellen remote url
* [n] beispiel für generische config
* [n] private config
* [n] arbeits config mit seperated ssh key 
* global definiertes gitignore file
* [n] beispiel

-->

# git - conditional includes

**~/.gitconfig**
```bash
[include]
  path = ~/.config/git/generic

[includeIf "gitdir:~/src/work/"]
  path = ~/.config/git/work

[includeIf "gitdir:~/src/private/"]
  path = ~/.config/git/private
```

. . .

 * gitdir & gitdir/i
 * onbranch `[includeIf "onbranch:foo-branch"]`
 * hasconfig:remote.*.url `[includeIf "hasconfig:remote.*.url:https://example.com/**"]`
    * > As for the naming of this keyword, it is for forwards compatibility with a naming scheme that supports more variable-based include conditions, but currently Git only supports the exact keyword described above.

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
