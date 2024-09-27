---

# fzf + cd

listing all your projects
```bash
$ find $HOME/src -maxdepth 1 -type d -printf "%f\n"
sachsencacher.de
slides
wrapped
[...]
```

. . .

combine with the `cd` command & store as an alias

```bash
$ alias gg='cd $HOME/src/"$(find $HOME/src -maxdepth 1 -type d -printf "%f\n" | sort -r | fzf)"'
```
