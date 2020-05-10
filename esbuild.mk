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
ESBUILD_TGZ := $(ESBUILD_PATH)\esbuild-$(ESBUILD_VERSION).tgz
esbuild := $(ESBUILD_INSTALL)\esbuild-$(ESBUILD_VERSION).exe

$(ESBUILD_INSTALL):
	md $(ESBUILD_INSTALL)

# Since 2018, `curl` and `tar` are available on Windows
# https://devblogs.microsoft.com/commandline/tar-and-curl-come-to-windows/

$(esbuild): | $(ESBUILD_INSTALL)
	curl -o $(ESBUILD_TGZ) https://registry.npmjs.org/esbuild-windows-64/-/esbuild-windows-64-$(ESBUILD_VERSION).tgz
	tar zxf $(ESBUILD_TGZ) -C $(ESBUILD_INSTALL)
	move $(ESBUILD_INSTALL)\package\esbuild.exe $(esbuild)
	del $(ESBUILD_TGZ)
	rd /s /q $(ESBUILD_INSTALL)\package

# end-windows
else
# begin-macos-linux

ESBUILD_TARGET := $(if $(findstring Darwin,$(shell uname -s)),darwin,linux)
esbuild := $(ESBUILD_INSTALL)/esbuild-$(ESBUILD_VERSION)

$(ESBUILD_INSTALL):
	mkdir -p $(ESBUILD_INSTALL)

$(esbuild): | $(ESBUILD_INSTALL)
	curl -o $(esbuild).tgz https://registry.npmjs.org/esbuild-$(ESBUILD_TARGET)-64/-/esbuild-$(ESBUILD_TARGET)-64-$(ESBUILD_VERSION).tgz
	tar zxf $(esbuild).tgz -C $(ESBUILD_INSTALL)
	mv $(ESBUILD_INSTALL)/package/bin/esbuild $(esbuild)
	rm -rf $(esbuild).tgz $(ESBUILD_INSTALL)/package

# end-macos-linux
endif