#!/bin/bash
# Simple Script to rebuild the fonts in this package.

# Parameters
fontname="SourceCodePro"
vend="adobe"

# Remove capitals from font
font=${fontname,,}

# Backup the hand-written package
mv tex/latex/$font/$font.sty tex/latex/$font/$font.sty.tmp

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
	-nosmallcaps						\
	-superiors							\
	-inferiors							\
	-fractions							\
	-noswash							\
	-notitling							\
	-noornaments						\
	-noupdmap

# Move the generated file and the hand-written one back
mv tex/latex/$font/$fontname.sty tex/latex/$font/$font-type1-autoinst.sty
mv tex/latex/$font/$font.sty.tmp tex/latex/$font/$font.sty

# Remove empty directories
find . -type d -empty -delete
