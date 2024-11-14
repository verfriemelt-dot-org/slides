---

# Makefile

> help your buddies to not forget

```Makefile
.PHONY: help compile watch run
help: ## Shows this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_\-\.]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

compile: ## creates final compiled.md
	rm -f compiled.md || true
	touch compiled.md
	for part in $$(find ./parts  -type f | sort); do (cat $$part; echo) >> compiled.md; done

watch: ## creates watcher with entr to recompile
	find parts | entr -c make compile

run: compile ## run patat in watcher mode
	patat -w compiled.md
```

. . . 

`make`
```
$ make
help                           Shows this help
compile                        creates final faster.md
watch                          creates watcher with entr to recompile
run                            run patat in watcher mode
```
