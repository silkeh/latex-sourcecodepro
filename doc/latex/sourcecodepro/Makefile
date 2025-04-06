PACKAGE  = sourcecodepro

all: README.md
	latexmk -pdflatex $(PACKAGE)-type1-specimen
	latexmk -xelatex  $(PACKAGE)-otf-specimen
	latexmk -xelatex  $(PACKAGE)

README.md: ../../../README.md
	cp -a $< $@

clean:
	latexmk -c

distclean:
	latexmk -C
	rm -f README.md

.PHONY: all clean distclean
