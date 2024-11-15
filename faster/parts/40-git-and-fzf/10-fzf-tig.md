---

# fzf + tig

**blame**
```bash
$ tig blame -- $(fzf)
```

. . .

create an alias

```bash
$ alias ffb='tig blame -- $(fzf)'
```

 * fast blaming via `$ ffb`
 * navigate with `,` to jump to selected parent
 * use `<` to jump back  
