#
# File:		Makefile.am
# Project:	EmacsTemplates 
# Desc:
#
#   automake source for Makefile.in
#
# Notes:
#
# Author(s):   Paul Houghton <pahoughton@users.sourceforge.net>
# Created:     05/26/2003 10:05
#
# Revision Info: (See ChangeLog or cvs log for revision history)
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
	default-m.tmpl				\
	default-php.tmpl			\
	default-pl.tmpl				\
	default-pm.tmpl				\
	default-sql.tmpl			\
	default-tmpl.tmpl			\
	default-txt.tmpl			\
	default-xml.tmpl			\
	default-xsl.tmpl			\
	main.C.tmpl

elisp_sources	=				\
	template-insert.el			\
	find-up-dir.el

emacs_type	= @pah_emacs_type@

XEmacs_el_sources	=			\
	$(elisp_sources)			\
	template-insert-config.el		\
	$(AUTOLOAD_PATH)/_pkg.el		\
	$(AUTOLOAD_PATH)/auto-autoloads.el	\
	$(AUTOLOAD_PATH)/custom-load.el


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
	$(AUTOLOAD_PATH)/_pkg.el		\
	$(AUTOLOAD_PATH)/auto-autoloads.el	\
	$(AUTOLOAD_PATH)/custom-load.el		\
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

$(AUTOLOAD_PATH)/_pkg.el: configure.ac
	@echo Creating $@
	@echo ";;;###autoload" > $@
	@echo "(package-provide '$(PACKAGE_NAME)" >> $@
	@echo "		 :version $(VERSION)" >> $@
	@echo "		 :type '$(PKG_TYPE))" >> $@

$(AUTOLOAD_PATH)/auto-autoloads.el : $(elisp_sources) $(AUTOLOAD_PATH)/_pkg.el
	$(EMACS) $(VANILLA) -batch \
		-l autoload 	\
		-f batch-update-directory \
		 $(AUTOLOAD_PATH)
	@rm -f $(AUTOLOAD_PATH)/auto-autoloads.el~

$(AUTOLOAD_PATH)/custom-load.el : $(elisp_sources)
	$(EMACS) $(VANILLA) -batch -l cus-dep 				\
		-f Custom-make-dependencies $(AUTOLOAD_PATH)

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

GNUEmacs_install: $(ELCS)
	$(hide) $(mkinstalldirs) $(DESTDIR)$(GNUEmacs_lisp_dir)
	$(hide) for f in $(template_files)		       \
			 $(GNUEmacs_el_sources)		       \
			 $(ELCS) ; do			       \
	  $(INSTALL) $$f $(DESTDIR)$(GNUEmacs_lisp_dir) ;      \
	  echo "Installed $(DESTDIR)$(GNUEmacs_lisp_dir)/$$f"; \
	done

install-data-hook: $(emacs_type)_install
