#!/bin/sh
# Simple Script to rebuild the fonts in this package.

font="sourcecodepro"
vend="adobe"

#mv fonts/enc/dvips/$font fonts/enc/dvips/$vend
#mv fonts/map/dvips/$font fonts/map/dvips/$vend

# Backup sty file
mv tex/latex/$font/$font.sty tex/latex/$font/$font.sty.tmp

#autoinst -typewriter -target=. -vendor="$vend" -typeface="$font" -encoding=OT1,T1,LY1,TS1 -noswash -notitling -noupdmap -nosuperiors -noornaments -noinferiors fonts/opentype/$vend/$font/*

# Font features (Version 1.017)
#aalt	Access All Alternates
#case	Case-Sensitive Forms
#ccmp	Glyph Composition/Decomposition
#dnom	Denominators
#frac	Fractions
#mark	Mark Positioning
#mkmk	Mark to Mark Positioning
#numr	Numerators
#onum	Oldstyle Figures
#ordn	Ordinals
#salt	Stylistic Alternates
#sinf	Scientific Inferiors
#size	Optical Size
#ss01	Stylistic Set 1
#ss02	Stylistic Set 2
#ss03	Stylistic Set 3
#ss04	Stylistic Set 4
#subs	Subscript
#sups	Superscript


autoinst fonts/opentype/$vend/$font/*	\
	-typewriter							\
	-target=.							\
	-vendor="$vend"						\
	-typeface="$font"					\
	-encoding=OT1,T1,LY1,TS1			\
	-ts1								\
	-smallcaps							\
	-superiors							\
	-inferiors							\
	-fractions							\
	-noswash							\
	-notitling							\
	-noornaments						\
	-noupdmap

mv tex/latex/$font/$font.sty tex/latex/$font/$font-type1-autoinst.sty
mv tex/latex/$font/$font.sty.tmp tex/latex/$font/$font.sty

#mv fonts/enc/dvips/$vend fonts/enc/dvips/$font
#mv fonts/map/dvips/$vend fonts/map/dvips/$font

rm -r fonts/type42
rm -r fonts/vpl
rm -r fonts/pl
rm -r fonts/truetype
