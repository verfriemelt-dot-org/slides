---

# zsh

> Zsh is a UNIX command interpreter (shell) usable as an interactive login shell and as a shell script command processor. Of the standard shells, zsh most closely resembles ksh but includes many enhancements. Zsh has command line editing, builtin spelling correction, programmable command completion, shell functions (with autoloading), a history mechanism, and a host of other features.

. . . 

# The Zsh Line Editor (ZLE) & `bindkey`

> The ZLE module contains three related builtin commands. The bindkey command manipulates keymaps and key bindings; the vared command invokes ZLE on the value of a shell parameter; and the zle command manipulates editing widgets and allows command line access to ZLE commands from within shell functions.

. . .

```bash
openRepository() {
    destination=$(find $HOME/src -mindepth 2 -maxdepth 2 | cut -d '/' -f 5- | sort -r | fzf)

    if [[ ! -z $destination ]]
    then
      cd "$destination"
      zle reset-prompt
    fi
}

zle -N openRepository
bindkey "^g^g" openRepository
```

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
demo #4
```

---

# The Zsh Line Editor (ZLE) & `bindkey`

https://zsh.sourceforge.io/Guide/zshguide04.html

```
    -s in-string out-string ...

        Bind each in-string to each out-string. When in-string is typed, 
        out-string will be pushed back and treated as input to the line editor. 
        When -R is also used, interpret the in-strings as ranges.
```

. . .

**git**
```bash
bindkey -s "^g^p" "git pull\n"
bindkey -s "^g^f" "git fetch --all\n"
bindkey -s "^g^u" "git push -u\n"
bindkey -s "^g^s" "git status\n"
bindkey -s "^g^d" "git diff\n"
bindkey -s "^g^b" "git checkout \$(gf -o -c)\n"
bindkey -s "^g^m" "git merge \$(gf -o)\n"
bindkey -s "^g^rc" "git rebase --continue\n"
bindkey -s "^g^rs" "git rebase --skip\n"
bindkey -s "^g^ra" "git rebase --abort\n"
bindkey -s "^g^a" "git add -p\n"

bindkey -s "^gc" "git commit -m \"\"\eOD"
```

. . . 

**docker**
```bash
bindkey -s "^b^u" "docker compose up\n"
bindkey -s "^b^b" "docker compose build --pull\n"
bindkey -s "^b^d" "docker compose down\n"
bindkey -s "^b^k" "docker compose down -v\n"
bindkey -s "^b^w" "docker compose exec php /bin/bash\n"
```

. . . 

**composer**
```bash
bindkey -s "^p^i" "composer install\n"
bindkey -s "^p^u" "composer update\n"
bindkey -s "^p^u^u" "composer update --no-scripts\n"
bindkey -s "^p^b" "composer bump\n"
bindkey -s "^p^o" "composer outdated --locked -D\n"
```

. . .

**php**
```bash
bindkey -s "^p^t" "phpunit\n"
bindkey -s "^p^r" "nice -19 rector\n"
bindkey -s "^p^s" "nice -19 phpstan -vvv\n"
bindkey -s "^p^f" "nice -19 infection --show-mutations --threads=max -vvv\n"
bindkey -s "^p^x" "[ -z \"\$XDEBUG_MODE\" ] && export XDEBUG_MODE=debug || unset XDEBUG_MODE \n"
bindkey -s "^p^w^t" "fd \\.php$ -E var/cache | entr -c phpunit\n"
bindkey -s "^p^w^s" "fd \\.php$ -E var/cache | entr -c nice -19 phpstan -vvv\n"
```

. . .

**gitlab**

```bash
bindkey -s "^o^m" ' -o merge_request.create'
bindkey -s "^o^n" ' -o merge_request.title=""\eOD'
bindkey -s "^o^l" ' -o merge_request.label=""\eOD'
bindkey -s "^o^t" ' -o merge_request.target=release/'
bindkey -s "^o^a" ' -o merge_request.merge_when_pipeline_succeeds'
bindkey -s "^g^u^m" 'git push -u -o merge_request.create -o merge_request.merge_when_pipeline_succeeds -o merge_request.title=""'
```
