# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# $@: The file name of the target of the rule.
# $<: The name of the first prerequisite.
# $^: The names of all the prerequisites, with spaces between them.
# $*: The matching string in a pattern rule.

.PHONY: _default build clean gen test xcode

_default: help

build: gen
	craft-swift

clean:
	rm -rf .build/*

clean-gen:
	rm src/Quilt{Vec,UI,SceneKit}/*-generated.swift

# all generated source targets.
gen: \
	src/QuiltVec/mat-generated.swift \
	src/QuiltVec/SIMD2-generated.swift \
	src/QuiltVec/SIMD3-generated.swift \
	src/QuiltVec/SIMD4-generated.swift \
	src/QuiltUI/CGVector-generated.swift \
	src/QuiltUI/V2-generated.swift \
	src/QuiltSceneKit/V3-generated.swift \
	src/QuiltSceneKit/V4-generated.swift

help: # Summarize the targets of this makefile.
	@GREP_COLOR="1;32" egrep --color=always '^\w[^ :]+:' makefile | sort

test: gen
	craft-swift-utest test


src/QuiltVec/mat-generated.swift: gen/mat.py gen/gen_util.py
	$< > $@

src/QuiltVec/SIMD%-generated.swift: gen/vec.py gen/gen_util.py
	$< SIMD$* > $@

src/QuiltUI/V2-generated.swift: gen/vec.py gen/gen_util.py
	$< V2 -alias=CGPoint -scalar=CGFloat -imports CoreGraphics QuiltVec > $@

src/QuiltUI/CGVector-generated.swift: gen/vec.py gen/gen_util.py
	$< CGVector -scalar=CGFloat -imports CoreGraphics QuiltVec > $@

src/QuiltSceneKit/V3-generated.swift: gen/vec.py gen/gen_util.py
	$< V3 -alias=SCNVector3 -scalar=CGFloat -imports SceneKit QuiltVec QuiltUI > $@

src/QuiltSceneKit/V4-generated.swift: gen/vec.py gen/gen_util.py
	$< V4 -alias=SCNVector4 -scalar=CGFloat -imports SceneKit QuiltVec QuiltUI > $@
