---

# working with multiple php versions

the non-docker user

```bash
$ php public/index.php

Fatal error: Composer detected issues in your platform: Your Composer dependencies require a 
PHP version ">= 8.3.0". You are running 8.2.24. in vendor/composer/platform_check.php on line 22
```

. . . 

```bash
$ ls /usr/bin/php*
/usr/bin/php5.6
/usr/bin/php7.0
/usr/bin/php7.1
/usr/bin/php7.2
/usr/bin/php7.3
/usr/bin/php7.4
/usr/bin/php8.0
/usr/bin/php8.1
/usr/bin/php8.2
/usr/bin/php8.3
/usr/bin/php8.4
```

for debian & ubuntu based systems: **https://deb.sury.org/**

. . . 

```bash
$ sudo update-alternatives --config php
There are 11 choices for the alternative php (providing /usr/bin/php).

  Selection    Path             Priority   Status
------------------------------------------------------------
* 0            /usr/bin/php8.4   84        auto mode
  1            /usr/bin/php5.6   56        manual mode
  2            /usr/bin/php7.0   70        manual mode
  3            /usr/bin/php7.1   71        manual mode
  4            /usr/bin/php7.2   72        manual mode
  5            /usr/bin/php7.3   73        manual mode
  6            /usr/bin/php7.4   74        manual mode
  7            /usr/bin/php8.0   80        manual mode
  8            /usr/bin/php8.1   81        manual mode
  9            /usr/bin/php8.2   82        manual mode
  10           /usr/bin/php8.3   83        manual mode
  11           /usr/bin/php8.4   84        manual mode

Press <enter> to keep the current choice[*], or type selection number:

```

---

# lets hack a script for that

assumptions:

 * we want to run the minimal supported php version by a project
 * if in a project, we want to use the projects version, otherwise the system default
 * version constraints for php often look like this
     * `"php": ">=8.1"`
     * `"php": "^7.4 || ^8.1"`
     * should be enough to grab the first one, usually they are sorted most of the times
     * never seen `"php": "^8.1 || ^7.4"`

---

**~/bin/php**
```bash
#!/usr/bin/env bash

# we want to be able to specify the version we want to run at all times
if [[ -n "${PHP}" ]]
then
    exec php"$PHP" "$@"
fi

# system-default if nothing specified
exec /usr/bin/php "$@"
```

. . . 

```bash
$ PHP=7.1 php --version
PHP 7.1.33-64+0~20240802.94+debian11~1.gbpa8e4d8 (cli) (built: Aug  2 2024 16:05:50) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2018 Zend Technologies
```

---

# in a project? 

```bash
# read from git repositories composer.json
_is_repository=$(git rev-parse --is-inside-work-tree 2>/dev/null)

# use default if not the case
if [[ -z $_is_repository ]]
then
    exec /usr/bin/php "$@"
fi
```

# checking for composer.json

```bash
_project_root=$( git rev-parse --show-toplevel )

# check for composer.json in project root
if [[ ! -f ${_project_root}/composer.json ]]
then
    exec /usr/bin/php "$@"
fi
```

---

# getting the php version from composer.json


```bash
# read supported versions and pick the latest one via head -n1
version=$(jq -r .require.php <"${_project_root}/composer.json" 2>/dev/null| grep -o "[0-9].[0-9]" | tail -n1)

# check if version is empty
if [[ -z "$version" ]]
then
    exec /usr/bin/php "$@"
fi

# check if version requested is available or default to the oldest
if command -v php"$version">/dev/null
then
    exec php"$version" "$@"
fi
```

--- 

# full script

```bash
#!/usr/bin/env bash

if [[ -n "${PHP}" ]]
then
    exec php"$PHP" "$@"
fi

_is_repository=$(git rev-parse --is-inside-work-tree 2>/dev/null)
if [[ -z $_is_repository ]]
then
    exec /usr/bin/php "$@"
fi

_project_root=$( git rev-parse --show-toplevel )
if [[ ! -f ${_project_root}/composer.json ]]
then
    exec /usr/bin/php "$@"
fi

version=$(jq -r .require.php <"${_project_root}/composer.json" 2>/dev/null| grep -o "[0-9].[0-9]" | tail -n1)
if [[ -z $version ]]
then
    exec /usr/bin/php "$@"
fi

if command -v php"$version">/dev/null
then
    exec php"$version" "$@"
fi

exec /usr/bin/php "$@"
```
