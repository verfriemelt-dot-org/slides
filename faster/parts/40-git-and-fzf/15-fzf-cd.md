---

# fzf + cd

listing all your projects
```bash
$ find $HOME/src -maxdepth 1 -type d -printf "%f\n"
```

. . .

create an alias

```bash
$ alias ffb='tig blame -- $(fzf)'
```

 * fast blaming via `$ ffb`
 * navigate with `,` to jump to selected parent
 * use `<` to jump back  
