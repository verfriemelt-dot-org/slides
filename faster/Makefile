.PHONY: help compile watch run
help: ## Shows this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_\-\.]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

compile: ## creates final faster.md
	rm faster.md || true
	touch faster.md
	for part in $$(find ./parts  -type f | sort); do (cat $$part; echo) >> faster.md; done

watch: ## creates watcher with entr to recompile
	find parts | entr -c make compile

run: ## run patat in watcher mode
	patat -w faster.md

