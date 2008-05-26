;;
;;  File:	get-pkg-basedir.el
;;  Project:	EmacsTemplates 
;;  Desc:
;;
;;	Return the base package dir for XEmacs or GNU Emacs
;;  
;;  Notes:
;;    
;;  Author(s):   Paul Houghton <pahoughton@users.sourceforge.net>
;;  Created:     05/27/2003 07:18
;;  
;;  Revision History: (See ChangeLog or cvs log for revision history)
;;  
;;	$Author$
;;	$Date$
;;	$Name$
;;	$Revision$
;;	$State$
;;
;;  $Id$
;;
(defun get-pkg-basedir ()
  "Return the base dir for installing elisp packages"
  (setq pkg-base-dir "")
  (if (string-match "XEmacs\\|Lucid" emacs-version)
      (if (or (> emacs-major-version 21)
	      (and (= emacs-major-version 21)
		   (>= emacs-minor-version 1)))
	  ( ;; Xemacs ver >= 21.1
	   
	   let* ((tmp-pkg-base-dir
		  (directory-file-name
		   (file-name-directory
		    (directory-file-name
		     (file-name-directory
		      (directory-file-name
		       (file-name-directory
			(feature-file
			(intern-soft "xemacs-base-autoloads"))))))))))
	    (if (and tmp-pkg-base-dir
		   (file-writable-p tmp-pkg-base-dir))
		(setq pkg-base-dir tmp-pkg-base-dir)
	      (setq pkg-base-dir (concat
				  (getenv "HOME")
				  "/.xemacs/xemacs-packages")))))
    ( ; Not Xemacs
     if (string-match "site-lisp" (car load-path))
	(setq pkg-base-dir (substring (car load-path) 0 (match-end 0)))
      (setq pkg-base-dir ""))
    )
)
