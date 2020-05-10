ESBUILD_VERSION := 0.2.10
ESBUILD_INSTALL := third_party
include esbuild.mk

.PHONY: all
all: test.min.js

test.min.js: test.ts $(esbuild)
	$(esbuild) --minify --outfile=test.min.js test.ts