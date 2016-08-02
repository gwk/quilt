# © 2014 George King. Permission to use this file is granted in license-quilt.txt.

# $@: The file name of the target of the rule.
# $<: The name of the first prerequisite.
# $^: The names of all the prerequisites, with spaces between them. 

.PHONY: default build clean gen test

default: build

build: gen
	swift build
	@echo done.

clean:
	rm -rf .build/*

# all generated source targets.
gen: \
	src/Quilt/mat-generated.swift \
	src/Quilt/vec-generated.swift \


# build prereq is necessary because `swift test` does not check for it as of xc8b1.
test: build
	swift test

src/Quilt/mat-generated.swift: gen/mat.py
	$^ > $@

src/Quilt/vec-generated.swift: gen/vec.py
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
