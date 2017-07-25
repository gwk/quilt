# © 2014 George King. Permission to use this file is granted in license-quilt.txt.

# $@: The file name of the target of the rule.
# $<: The name of the first prerequisite.
# $^: The names of all the prerequisites, with spaces between them.

.PHONY: _default build clean gen test xcode

_default: build

build: gen
	swift build --build-path _build | swift-plumage
	@echo done.

clean:
	rm -rf _build/*

# all generated source targets.
gen: \
	src/Quilt/mat-generated.swift \
	src/Quilt/vec-generated.swift \
	src/QuiltBridge/CGPoint-generated.swift \
	src/QuiltBridge/CGVector-generated.swift \
	src/QuiltSceneKit/V3-generated.swift \
	src/QuiltSceneKit/V4-generated.swift

test: build
	swift test --build-path _build

xcode:
	swift package generate-xcodeproj

src/Quilt/mat-generated.swift: gen/mat.py
	$^ > $@

src/Quilt/vec-generated.swift: gen/vec.py
	$^ > $@

src/QuiltBridge/CGPoint-generated.swift: gen/vec.py
	$^ CGPoint 2 Flt Flt CoreGraphics Quilt > $@

src/QuiltBridge/CGVector-generated.swift: gen/vec.py
	$^ CGVector 2 Flt Flt CoreGraphics Quilt > $@

src/QuiltSceneKit/V3-generated.swift: gen/vec.py
	$^ V3 3 Flt Flt SceneKit Quilt QuiltBridge > $@

src/QuiltSceneKit/V4-generated.swift: gen/vec.py
	$^ V4 4 Flt Flt SceneKit Quilt QuiltBridge > $@

