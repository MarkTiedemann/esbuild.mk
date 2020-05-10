# This Makefile was downloaded from: https://raw.githubusercontent.com/MarkTiedemann/esbuild.mk/master/esbuild.mk
# For documentation on how to use it, see: https://github.com/MarkTiedemann/esbuild.mk

.DEFAULT_GOAL := all

ifndef ESBUILD_VERSION
$(error $$ESBUILD_VERSION must be set)
endif

ESBUILD_INSTALL ?= .

ifeq ($(OS),Windows_NT)
# begin-windows

SHELL := cmd.exe

# TODO(Mark): Add Windows build

# end-windows
else
# begin-macos-linux

ESBUILD_TARGET := $(if $(findstring Darwin,$(shell uname -s)),darwin,linux)
esbuild := $(ESBUILD_INSTALL)/esbuild-$(ESBUILD_VERSION)

$(ESBUILD_INSTALL):
	mkdir -p $(ESBUILD_INSTALL)

$(esbuild): | $(ESBUILD_INSTALL)
	curl -o $(esbuild).tgz -C - https://registry.npmjs.org/esbuild-$(ESBUILD_TARGET)-64/-/esbuild-$(ESBUILD_TARGET)-64-$(ESBUILD_VERSION).tgz
	tar zxf $(esbuild).tgz -C $(ESBUILD_INSTALL)
	mv $(ESBUILD_INSTALL)/package/bin/esbuild $(esbuild)
	rm -rf $(esbuild).tgz $(ESBUILD_INSTALL)/package

# end-macos-linux
endif
