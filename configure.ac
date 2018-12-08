dnl
dnl File:	configure.ac
dnl Project:	emacs-templates
dnl Desc:
dnl
dnl   Process this file with autoconf to produce a configure script.
dnl
dnl Author(s):   Paul Houghton <paul4hough@gmail.com>
dnl Created:     05/26/2003 10:09
dnl

AC_PREREQ(2.57)
AC_INIT( emacs-templates,
	 2.01.00,
	 Paul Houghton <paul4hough@gmail.com> )

AM_INIT_AUTOMAKE([-Wno-portability])

AC_ARG_VAR( EMACS, which emacs to use (xemacs,emacs) default is emacs )

PAH_PROG_EMACS
PAH_PATH_LISPDIR
PAH_GITHOST
PAH_GITDIR

# Checks for programs.

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 template-insert.el
		 tests/unit/Makefile
		 tests/system/Makefile])
AC_OUTPUT
