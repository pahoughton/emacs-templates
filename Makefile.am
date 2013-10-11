#
# File:		Makefile.am
# Project:	emacs-templates
# Desc:
#
#   automake source for Makefile.in
#
# Author(s):   Paul Houghton <paul4hough@gmail.com>
# Created:     05/26/2003 10:05
#

SUBDIRS	= tests/unit tests/system

template_files = $(wildcard *.tmpl)

elisp_sources	=				\
	template-insert.el			\
	find-up-dir.el

emacs_type	= @pah_emacs_type@

XEmacs_el_sources	=			\
	$(elisp_sources)			\
	template-insert-config.el


XEmacs_tmpl_dir	= $(lispdir)/etc/$(PACKAGE_NAME)
XEmacs_lisp_dir	= $(lispdir)/lisp/$(PACKAGE_NAME)

XEmacs_install_dirs	=			\
	$(XEmacs_tmpl_dir)			\
	$(XEmacs_lisp_dir)

PKG_TYPE		= regular
AUTOLOAD_PATH		= .
AUTOLOAD_PACKAGE_NAME 	= "$(PACKAGE_NAME)"


GNUEmacs_el_sources	=			\
	$(elisp_sources)			\
	template-insert-config.el

GNUEmacs_tmpl_dir	= $(lispdir)/$(PACKAGE_NAME)
GNUEmacs_lisp_dir	= $(lispdir)/$(PACKAGE_NAME)

GNUEmacs_install_dirs	=			\
	$(GNUEmacs_lisp_dir)


ELCS	=	$($(emacs_type)_el_sources:.el=.elc)



EXTRA_DIST	=				\
	$(template_files)			\
	$(elisp_sources)			\
	subdirs.el				\
	get-pkg-basedir.el

CLEANFILES		= $(ELCS)

hide = @

SUFFIXES = .elc .el

.el.elc:
	$(EMACS) -batch -q					    \
		-eval "(setq load-path (append '(\".\") load-path))" \
		-f batch-byte-compile $^

template-insert-config.el: config.status
	@echo Creating $@
	$(hide) echo ";; This file is generated DO NOT EDIT" > $@
	$(hide) echo "(setq template-insert-package-name \"$(PACKAGE_NAME)\")" >> $@
	$(hide) echo "(setq template-insert-tmpl-dir \"$($(emacs_type)_tmpl_dir)\")" >> $@
	$(hide) echo "(provide 'template-insert-config)" >> $@

template-insert.elc: template-insert-config.el

loaddefs.el: $(elisp_sources) template-insert-config.el
	$(hide)$(EMACS) $(VANILLA) -batch	\
		--no-site-file 			\
		-l autoload			\
		 --eval '(setq generated-autoload-file (concat (file-name-directory (file-truename "Makefile.am")) "loaddefs.el"))' \
		-f batch-update-autoloads .

cus-load.el: $(elisp_sources)
	$(hide)$(EMACS) $(VANILLA) -batch -l cus-dep 	\
		-f custom-make-dependencies .

XEmacs_install: $(ELCS)
	$(hide) $(mkinstalldirs) $(DESTDIR)$(XEmacs_tmpl_dir)
	$(hide) for f in $(template_files) ; do		    \
	  $(INSTALL) $$f $(DESTDIR)$(XEmacs_tmpl_dir) ;	    \
	  echo "Installed $(DESTDIR)$(XEmacs_tmpl_dir)/$$f"; \
	done
	$(hide) $(mkinstalldirs) $(DESTDIR)$(XEmacs_lisp_dir)
	$(hide) for f in $(XEmacs_el_sources) $(ELCS) ; do   \
	  $(INSTALL) $$f $(DESTDIR)$(XEmacs_lisp_dir) ;	     \
	  echo "Installed $(DESTDIR)$(XEmacs_lisp_dir)/$$f"; \
	done

GNUEmacs_install: $(ELCS) loaddefs.el
	$(hide) $(mkinstalldirs) $(DESTDIR)$(GNUEmacs_lisp_dir)
	$(hide) for f in $(template_files)		       \
			 $(GNUEmacs_el_sources)		       \
			 $(ELCS) ; do			       \
	  $(INSTALL) "$$f" $(DESTDIR)$(GNUEmacs_lisp_dir) || exit 1 ;      \
	  echo "Installed $(DESTDIR)$(GNUEmacs_lisp_dir)/$$f"; \
	done
	$(hide) $(INSTALL) subdirs.el "$(lispdir)"
	@echo "Installed $(lispdir)/subdirs.el"
	$(hide)if [ -f "$(lispdir)/loaddefs.el" ] ; then	\
	  mv "$(lispdir)/loaddefs.el" 				\
	     "$(lispdir)/loaddefs.el.bak" &&     		\
	  cat "$(lispdir)/loaddefs.el.bak" 			\
	      loaddefs.el					\
	      > "$(lispdir)/loaddefs.el" || exit 1;		\
	else							\
	  $(INSTALL) -p -m 644 loaddefs.el "$(lispdir)";	\
	fi
	[ -f "$(lispdir)/loaddefs.el" ] || exit 2

install-data-hook: $(emacs_type)_install

all: template-insert-config.el $(ELCS)

check: all

test: check

test-system: check
	$(MAKE) -C tests/system "${@}-real"

check-system: test-system
