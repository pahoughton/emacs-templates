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

test_simple = $(top_srcdir)/test_tmp/emacs-test-simple/test-simple.el

$(test_simple):
	$(hide)if [ ! -f "$(top_srcdir)/test_tmp/.sloccount.skip" ] ; then  \
	  ${mkdir_p} "$(top_srcdir)/test_tmp";				    \
	  touch "${top_srcdir}/test_tmp/.sloccount.skip";		    \
	fi
	$(hide)(cd "$(top_srcdir)/test_tmp" &&				\
	  git clone https://github.com/rocky/emacs-test-simple)

#: same thing as "check"
test: check

test_files := $(wildcard test*.el)
EXTRA_DIST	= $(wildcard *.el)

CHECK_FILES = $(notdir $(test_files:.el=.run))

# ARG autoconf doesn't build all before check
top_all:
	$(MAKE) -C ${top_srcdir} all

check: top_all $(test_simple) $(CHECK_FILES)
	echo $(test_files) - $(CHECK_FILES)

test%.run:
	$(EMACS) --batch --no-site-file --no-splash --load $(@:.run=.el)

