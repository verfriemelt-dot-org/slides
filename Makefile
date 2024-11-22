build:
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
		echo "<a href='$$dirindex.html'>$$dir</a>" >> index.html ; \
	done


