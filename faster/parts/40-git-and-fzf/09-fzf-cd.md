---

<!--
^a1 für demo
-->

# fzf + cd

listing all your projects
```bash
$ find $HOME/src -mindepth 2 -maxdepth 2 | cut -d '/' -f 5-
private/phpstan-src
private/infection
private/slides
private/symfony1
private/phpunit
private/PHP-CS-Fixer
private/symfony
private/wrapped
private/timer
private/sachsencacher.de
work/frankenphp
work/matomo
work/laravel
```

. . .

combine with the `cd` command & store as an alias

```bash
$ alias gg='cd $HOME/src/"$(find $HOME/src -mindepth 2 -maxdepth 2 | cut -d '/' -f 5- | sort -r | fzf)"'
```


