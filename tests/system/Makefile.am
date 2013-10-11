#
# File:	    Makefile.am
# Project:  emacs-utils
# Desc:
#
#   automake source for Makefile.in
#
# Author(s):   Paul Houghton <paul4hough@gmail.com>
# Created:     2013-10-08 10:42
#

EXTRA_DIST	= test-system.bash		\
		  test-template-insert-sys.el

PHONY=check test all

test: check

test_files := $(wildcard test-*.el)

check:

test-system-real:
	bash test-system.bash $(abs_top_srcdir) $(lispdir)


%:
	$(MAKE) -C ../.. "$@"
