# 2003-01-06 (cc) Paul Houghton <paul4hough@gmail.com>
#

AC_DEFUN([PAH_PROG_EMACS],
[ AC_CACHE_SAVE
  test x"$EMACS" = xt && EMACS=
  AC_CHECK_PROGS(EMACS, emacs xemacs, no)
  AC_CACHE_CHECK([which version of emacs],pah_cv_emacs_type,
    [ if test $EMACS != "no"; then
        AC_RUN_LOG([$EMACS -batch -q -eval '(if (string-match "XEmacs\\|Lucid" emacs-version)(princ "XEmacs")(princ "GNUEmacs"))' 2> /dev/null > conftest.out])
        pah_cv_emacs_type=`echo \`cat conftest.out\``
        rm conftest.out
      else
        AC_MSG_ERROR([Sorry, did not find a usable emacs])
      fi
    ])
  pah_emacs_type="$pah_cv_emacs_type"
  AC_SUBST(pah_emacs_type)
])


AC_DEFUN([PAH_PATH_LISPDIR],
[AC_ARG_WITH(lispdir,
  AC_HELP_STRING([--with-lispdir],[Override the default lisp directory]),
    [ lispdir="$withval"
      AC_MSG_RESULT([$lispdir])],
    [
     if test x${lispdir+set} != xset; then
       AC_CACHE_CHECK([where emacs package files should go], [pah_cv_lispdir],
       [# If $EMACS isn't GNU Emacs or XEmacs, this can blow up pretty badly
        # Some emacsen will start up in interactive mode, requiring C-x C-c to exit,
        #  which is non-obvious for non-emacs users.
        # Redirecting /dev/null should help a bit; pity we can't detect "broken"
        #  emacsen earlier and avoid running this altogether.
        AC_RUN_LOG([$EMACS -batch -q -l ${srcdir}/get-pkg-basedir.el -eval '(princ (get-pkg-basedir))' 2> /dev/null >conftest.out])
        pah_cv_lispdir=`echo \`cat conftest.out\``
        rm conftest.out
        if test -z "$pah_cv_lispdir"; then
          pah_cv_lispdir='${datadir}/emacs/site-lisp'
        fi
       ])
       lispdir="$pah_cv_lispdir"
     fi
    ])
  AC_SUBST(lispdir)
])# PAH_PATH_LISPDIR

AC_DEFUN([PAH_GITHOST],
[ AC_ARG_WITH(githost,
  AC_HELP_STRING([--with-githost],[Override the default git repo host]),
  [ githost="$withval"
    AC_MSG_RESULT([$githost])],
  [ if test x${githost+xset} != xset; then
      AC_CACHE_CHECK([value for githost], [pah_cv_githost],
        [pah_cv_githost=github.com])
      githost="$pah_cv_githost"
    fi
  ])
  AC_SUBST(githost)
])

AC_DEFUN([PAH_GITDIR],
[ AC_ARG_WITH(gitdir,
  AC_HELP_STRING([--with-gitdir],[Override the default git repo dir]),
  [ gitdir="$withval"
    AC_MSG_RESULT([$gitdir])],
  [ if test x${gitdir+xset} != xset; then
      AC_CACHE_CHECK([value for gitdir], [pah_cv_gitdir],
        [pah_cv_gitdir=pahoughton])
      gitdir="$pah_cv_gitdir"
    fi
  ])
  AC_SUBST(gitdir)
])
