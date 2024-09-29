---

# vendor/bin/phpunit? bin/phpunit? ./phpunit?

```bash
#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

bin=$(basename "$0")
realpath=$(realpath "$0")

for path in "vendor/bin/$bin" "bin/$bin" "lib/vendor/bin/$bin"; do
    if [[ -f "$path" && $(realpath "$path") != "$realpath" ]]
        then
        exec "$path" "$@"
    fi
done

echo "$bin not found"
exit 1;
```

. . .

usage:

```bash
$ cd ~/bin
$ ln -s bin-proxy phpunit
$ ln -s bin-proxy rector
$ ln -s bin-proxy infection
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
demo #1
```
