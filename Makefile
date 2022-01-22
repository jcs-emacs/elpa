SHELL := /usr/bin/env bash

EMACS ?= emacs
CASK ?= cask

.PHONY: startup

build:
	@echo "Testing..."
	@$(EMACS) -nw --batch -l "./docs/scripts/build.el"
