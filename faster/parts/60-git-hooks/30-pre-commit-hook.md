---

# pre-commit-hook

what does this tell you?

```
95f0efe 2024-07-22 12:32:14 +0200 95f0efe stan .......
e990c3d 2024-07-22 12:24:55 +0200 e990c3d stan ......
7c3da72 2024-07-22 12:14:19 +0200 7c3da72 stan .....
a58533e 2024-07-22 12:06:22 +0200 a58533e stan ....
a7ffe04 2024-07-22 11:58:01 +0200 a7ffe04 stan ..
5875eec 2024-07-22 10:31:16 +0200 5875eec cs fixer .
7e379cb 2024-07-22 10:26:33 +0200 7e379cb stan .
2eed927 2024-07-22 10:16:43 +0200 2eed927 correct versions array
```

. . .

hint: typical pipelineruns at the time took about 3 minutes

. . . 

# what is required for pushing code and a green pipeline?

 * not push to a protected branch
 * code needs to be valid code
 * tests must pass
 * phpstan must not complain
 * rector rules must not be violated
 * csfixer must not complain

---

# pre-commit hook

> The pre-commit hook is run first, before you even type in a commit message. It’s used to inspect the snapshot that’s about to be committed, to see if you’ve forgotten something, to make sure tests run, or to examine whatever you need to inspect in the code. Exiting non-zero from this hook aborts the commit, although you can bypass it with git commit `--no-verify`. 

. . . 

# how to start

`~/.githooks/pre-commit`
```bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $script_dir/common/prepare.sh

if [[ $(pwd) =~ /work/ ]]
then
  is_work="true"
fi

# include all pre-commit parts
for hook in $script_dir/pre-commit.d/*
do
  if [[ ! -z $skip && $hook =~ $skip ]]
  then
    continue
  fi

  source "$hook"
done
```
---

# pre-commit-hook » branch protection

`~/.githooks/pre-commit.d/10-branchproection.sh`
```bash
#!/usr/bin/env bash

# protect some important branches
branchprotection='^refs\/heads\/(release|develop|master|main|[0-9]+\.x$)'

if [[ $_git_branchname =~ $branchprotection  ]]
then
  echo "${red}$_git_branchname is writeable via PRs only" >&2
  exit 1;
fi
```

---

# pre-commit-hook » linting

`~/.githooks/pre-commit.d/15-lint.sh`
```bash
#!/bin/bash

# find staged php files
staged_files=( $(git diff-index --cached --name-only --diff-filter=d HEAD | grep -E '\.php$') )
[[ ${#staged_files} -eq 0 ]] && return

# run
echo "php:     ${white}`command -v php`${reset}"
echo "version: ${white}$( php -r "echo PHP_VERSION;" )${reset}"
echo "checking ${green}${#staged_files[@]}${reset} files"
echo ""

result=0
for file in ${staged_files[@]}
do
    lintresult=$(php -l "$file")

    if [[ $? -eq 0 ]]
    then
      echo "    ${green}$file${reset}"
    else
      echo "    ${red}$file${reset}"
      echo $lintresult | sed 's/^/      /g'

      result=1
    fi
done

[[ $result -ne 0 ]] && exit $result
```

---

# pre-commit-hook » tests

`~/.githooks/pre-commit.d/20-tests.sh`
```bash
#!/usr/bin/env bash

possible_config_paths=( "$_git_root/phpunit.xml" "$_git_root/phpunit.xml.dist" "$_git_root/phpunit.dist.xml" )

for file in ${possible_config_paths[@]}
do
  if [[ -f $file ]]
  then
      config_path=$file
      break
  fi
done
[[ -z $config_path ]] && return

possible_paths=( "$_git_root/bin/paratest" "$_git_root/bin/phpunit" "$_git_root/vendor/bin/paratest" "$_git_root/vendor/bin/phpunit" )
for phpunit_path in ${possible_paths[@]}
do
  if [[ -f $phpunit_path ]]
  then
    phpunit_bin=$phpunit_path
    break
  fi
done

echo "bin: ${white}$phpunit_bin${reset}"
echo "conf: ${white}$config_path${reset}"
echo "version: ${white}$( $phpunit_bin --version )${reset}"
echo ""

$phpunit_bin -c $config_path
[[ $? -ne 0 ]] && exit 1
```

---

# pre-commit-hook » phpstan

`~/.githooks/pre-commit.d/30-phpstan.sh`
```bash
#!/usr/bin/env bash

possible_config_paths=( "$_git_root/phpstan.neon" "$_git_root/phpstan.dist.neon" )
for file in ${possible_config_paths[@]}
do
  if [[ -f $file ]]
  then
      config_path=$file
      break
  fi
done
[[ -z $config_path ]] && return

staged_files=( $(git diff-index --cached --name-only --diff-filter=d HEAD | grep -E '\.php$') )
[[ ${#staged_files} -eq 0 ]] && return

possible_paths=( "$_git_root/bin/phpstan" "$_git_root/vendor/bin/phpstan" "$_git_root/lib/vendor/bin/phpstan" )
for phpstan_path in ${possible_paths[@]}
do
  if [[ -f $phpstan_path ]]
  then
    phpstan_bin=$phpstan_path
    break
  fi
done
[[ -z $phpstan_bin ]] && exit 1

echo "bin: ${white}$phpstan_bin${reset}"
echo "conf: ${white}$phpstan_conf${reset}"
echo "version: ${white}$( $phpstan_bin --version )${reset}"

nice -19 $phpstan_bin analyse -vv -c $phpstan_conf

[[ $? -ne 0 ]] && exit 1
```

---

# pre-commit-hook » rector

`~/.githooks/pre-commit.d/40-rector.sh`
```bash
#!/usr/bin/env bash

# more of the same

nice -19 $rector_bin process --dry-run --config $rector_conf 

if [[ $? -gt 0 ]]
then
  exec < /dev/tty
  read -p 'apply changes? (Y/n) ' yn

  if [[ $yn = 'n' ]]
  then
    echo 'aborting commit'
    exit 1
  fi

  nice -19 $rector_bin process --config $rector_conf

  # readd files to commit
  git add ${staged_files[@]}
fi
```

---

# pre-commit-hook » csfixer

`~/.githooks/pre-commit.d/50-csfixer.sh`
```bash

$csfixer_bin --config=$config_path fix --using-cache=no -v --path-mode=intersection --dry-run --diff -- ${staged_files[@]}

if [[ $? -gt 0 ]]
then

  exec < /dev/tty
  read -p 'fix codestlye? (Y/n) ' yn

  if [[ $yn = 'n' ]]
  then
    echo 'aborting commit'
    exit 1
  fi

  $csfixer_bin --config=$config_path fix --using-cache=no --path-mode=intersection -- ${staged_files[@]}

  # readd files to commit
  git add ${staged_files[@]}

fi
```

---

# pre-commit-hook » final structure

```bash
$ tree ~/.githooks
.
├── pre-commit
└── pre-commit.d
    ├── 10-branchproection.sh
    ├── 15-lint.sh
    ├── 20-tests.sh
    ├── 30-phpstan.sh
    ├── 40-rector.sh
    └── 50-csfixer.sh
```

. . .

```bash
  if [[ ! -z $skip && $hook =~ $skip ]]
  then
    continue
  fi
```

. . . 

```bash
$ skip=. git commit -m 'fix typo' readme.md
```

. . .

```bash
$ skip=phpstan git commit -am 'resolv phpstan baseline'
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
demo #2
```
