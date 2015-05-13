#!/bin/bash
# Simple Script to rebuild the fonts in this package.

# Parameters
fontname="SourceCodePro"
vend="adobe"

# Remove capitals from font
font=${fontname,,}

# Backup the hand-written package
mv tex/latex/$font/$font.sty tex/latex/$font/$font.sty.tmp

# Convert the OpenType fonts
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
