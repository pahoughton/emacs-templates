#
# File:		Makefile.am
# Project:	EmacsTemplates 
# Desc:
#
#   automake source for Makefile.in
#
# Notes:
#
# Author(s):   Paul Houghton <paul.houghton@mci.com>
# Created:     05/26/2003 10:05
#
# Revision History: (See end of file for Revision Log)
#
#	$Author$
#	$Date$
#	$Name$
#	$Revision$
#	$State$
#
# $Id$
#


template_files =				\
	Makefile.am.tmpl			\
	Makefile.tmpl				\
	default-C.tmpl				\
	default-c-block.tmpl			\
	default-dtd-block.tmpl			\
	default-dtd.tmpl			\
	default-el.tmpl				\
	default-h.tmpl				\
	default-hh.tmpl				\
	default-ii.tmpl				\
	default-java.tmpl			\
	default-php.tmpl			\
	default-pl.tmpl				\
	default-pm.tmpl				\
	default-sql.tmpl			\
	default-tmpl.tmpl			\
	default-txt.tmpl			\
	default-xml.tmpl			\
	default-xsl.tmpl			\
	main.C.tmpl

elisp_sources	= template-insert.el

emacs_type	= @pah_emacs_type@

XEmacs_el_sources	=			\
	$(elisp_sources)			\
	$(AUTOLOAD_PATH)/_pkg.el		\
	$(AUTOLOAD_PATH)/auto-autoloads.el	\
	$(AUTOLOAD_PATH)/custom-load.el


XEmacs_etc_dir	= $(lispdir)/etc/$(PACKAGE_NAME)
XEmacs_lisp_dir	= $(lispdir)/lisp/$(PACKAGE_NAME)

XEmacs_install_dirs	=			\
	$(XEmacs_etc_dir)			\
	$(XEmacs_lisp_dir)

PKG_TYPE		= regular
AUTOLOAD_PATH		= .
AUTOLOAD_PACKAGE_NAME 	= (setq autoload-package-name \"$(PACKAGE_NAME)\")


GNUEmacs_el_sources	= $(elisp_sources)

GNUEmacs_etc_dir	= $(lispdir)/$(PACKAGE_NAME)
GNUEmacs_lisp_dir	= $(lispdir)/$(PACKAGE_NAME)

GNUEmacs_install_dirs	=			\
	$(GNUEmacs_lisp_dir)


ELCS	=	$($(emacs_type)_el_sources:.el=.elc)



dist_noinst_DATA	= $(template_files) $(XEmacs_el_sources)
CLEANFILES		= $(ELCS)

hide = @

SUFFIXES = .elc .el

.el.elc:
	$(EMACS) -batch -q -f batch-byte-compile $^


$(AUTOLOAD_PATH)/_pkg.el: configure.ac
	@echo Creating $@
	@echo ";;;###autoload" > $@
	@echo "(package-provide '$(PACKAGE_NAME)" >> $@
	@echo "		 :version $(VERSION)" >> $@
	@echo "		 :type '$(PKG_TYPE))" >> $@

$(AUTOLOAD_PATH)/auto-autoloads.el : $(elisp_sources) $(AUTOLOAD_PATH)/_pkg.el
	$(EMACS) $(VANILLA) -batch \
		-eval "$(AUTOLOAD_PACKAGE_NAME)" 			\
		-l autoload -f batch-update-directory $(AUTOLOAD_PATH)
	@rm -f $(AUTOLOAD_PATH)/auto-autoloads.el~

$(AUTOLOAD_PATH)/custom-load.el : $(elisp_sources)
	$(EMACS) $(VANILLA) -batch -l cus-dep 				\
		-f Custom-make-dependencies $(AUTOLOAD_PATH)

XEmacs_install: $(ELCS)
	$(hide) $(mkinstalldirs) $(DESTDIR)$(XEmacs_etc_dir)
	$(hide) for f in $(template_files) ; do		    \
	  $(INSTALL) $$f $(DESTDIR)$(XEmacs_etc_dir) ;	    \
	  echo "Installed $(DESTDIR)$(XEmacs_etc_dir)/$$f"; \
	done
	$(hide) $(mkinstalldirs) $(DESTDIR)$(XEmacs_lisp_dir)
	$(hide) for f in $(XEmacs_el_sources) $(ELCS) ; do   \
	  $(INSTALL) $$f $(DESTDIR)$(XEmacs_lisp_dir) ;	     \
	  echo "Installed $(DESTDIR)$(XEmacs_lisp_dir)/$$f"; \
	done

GNUEmacs_install: $(ELCS)
	$(hide) $(mkinstalldirs) $(DESTDIR)$(GNUEmacs_lisp_dir)
	$(hide) for f in $(template_files)		       \
			 $(GNUEmacs_el_sources)		       \
			 $(ELCS) ; do			       \
	  $(INSTALL) $$f $(DESTDIR)$(GNUEmacs_lisp_dir) ;      \
	  echo "Installed $(DESTDIR)$(GNUEmacs_lisp_dir)/$$f"; \
	done

install-data-hook: $(emacs_type)_install
