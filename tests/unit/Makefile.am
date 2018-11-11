#
# File:		Makefile.am
# Project:	emacs-utils
# Desc:
#
#   automake source for Makefile.in
#
# Author(s):   Paul Houghton <paul4hough@gmail.com>
# Created:     2013-10-08 09:20
#

PHONY=check test all


#: same thing as "check"
test: check

test_files := $(wildcard test*.el)
EXTRA_DIST	= $(wildcard *.el)

CHECK_FILES = $(notdir $(test_files:.el=.run))

check: $(CHECK_FILES)
	echo $(test_files) - $(CHECK_FILES)

test%.run:
	$(EMACS) --batch -load $(@:.run=.el) -f ert-run-tests-batch-and-exit
