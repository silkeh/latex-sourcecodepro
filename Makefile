PACKAGE  = sourcecodepro
OTF_NAME = SourceCodePro
FONTNAME = SourceCodePro
VENDOR   = adobe

TEX_DIR  = tex/latex/$(PACKAGE)
DOC_DIR  = doc/latex/$(PACKAGE)
OTF_DIR  = fonts/opentype/$(VENDOR)/$(PACKAGE)
MAP_OUT  = fonts/map/dvips/$(PACKAGE)/$(FONTNAME).map
PKG_OUT  = $(TEX_DIR)/$(PACKAGE)-type1-autoinst.sty

ENCS =

all: $(PACKAGE).tds.zip $(PACKAGE).pdf

fonts: $(PKG_OUT)

docs: fonts
	$(MAKE) -C $(DOC_DIR)

$(PACKAGE).tds.zip: $(PACKAGE).files
	zip $(PACKAGE).tds.zip -@ < $^

$(PACKAGE).zip: $(PACKAGE).tds.zip
	create-ctan-zip $< $(PACKAGE)

$(PACKAGE).pdf: docs
	cp doc/latex/$(PACKAGE)/*.pdf ./

$(PACKAGE).files: fonts docs
	find tex/   -type f  > $@
	find fonts/ -type f >> $@
	find doc/ -name "*.md" \
		-o -name "*.txt" \
		-o -name "*.pdf" \
		-o -name "*.tex" >> $@

$(PKG_OUT): $(OTF_DIR)/$(OTF_NAME)-Regular.otf $(ENCS)
	autoinst fonts/opentype/$(VENDOR)/$(PACKAGE)/*   \
		-typewriter                         \
		-target=.                           \
		-vendor="$(VENDOR)"                 \
		-typeface="$(PACKAGE)"              \
		-encoding=OT1,T1,LY1,TS1,T2A        \
		-nosmallcaps                        \
		-noswash                            \
		-notitling                          \
		-fractions                          \
		-noornaments
	if [ $${UID:-0} -ne 0 ]; then updmap -user; fi
	mv $(TEX_DIR)/$(FONTNAME).sty $(PKG_OUT)

clean:
	$(MAKE) -C $(DOC_DIR) clean
	find . -type d -empty -delete
	rm -f $(ENCS)
	rm -f *.zip
	rm -f $(PACKAGE).files

distclean: clean
	$(MAKE) -C $(DOC_DIR) distclean
	rm -f *.log
	rm -rf fonts/{enc,map,tfm,type1,vf}
	rm -f tex/latex/$(PACKAGE)/*.fd
	rm -f tex/latex/$(PACKAGE)/*-autoinst.sty
	rm -f tex/latex/$(PACKAGE)/$(FONTNAME).sty

.PHONY: all docs clean distclean .files
