SHELL := /bin/bash

build:
	@rm index.html || true
	@echo "<h1>slides:</h1>" >> index.html ; \
	@echo "<p>slides are intented to be displayed with patat! might not fully work with revealjs</p>" >> index.html ; \
	@echo "<ul>" >> index.html ; \
	for dir in */; do \
		echo $$dir; \
		make compile -C $$dir ; \
		pandoc \
			-t revealjs \
			-s \
			-V theme:dracula \
			-H revealjs.style.html \
			--slide-level 3 \
			-o $$dir/index.html \
			$$dir/compiled.md \
		; \
		echo "<a href=$${dir}index.html>$${dir/\//}</a>" >> index.html ; \
	done
	@echo "</ul>" >> index.html ; \

