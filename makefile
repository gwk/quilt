# © 2014 George King. Permission to use this file is granted in license-quilt.txt.

# $@: The file name of the target of the rule.
# $<: The name of the first prerequisite.
# $^: The names of all the prerequisites, with spaces between them. 

default: all

.PHONY: default all clean gen

all: gen
	swift build

clean:
	rm -rf .build/*

# all generated source targets.
gen: \
	src/mat-generated.swift \
	src/vec-generated.swift \

src/mat-generated.swift: gen/mat.py
	$^ > $@

src/vec-generated.swift: gen/vec.py
	$^ > $@

#src/CGPoint-generated.swift: gen/vec.py
#	$^ CGPoint 2 Flt Flt CoreGraphics > $@
#
#src/CGVector-generated.swift: gen/vec.py
#	$^ CGVector 2 Flt Flt CoreGraphics > $@
#
#src/V3-generated.swift: gen/vec.py
#	$^ V3 3 Flt Flt SceneKit > $@
#
#src/scn/V4-generated.swift: gen/vec.py
#	$^ V4 4 Flt Flt SceneKit > $@
#
