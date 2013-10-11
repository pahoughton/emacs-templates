;;
;;  File:	find-up-dir.el
;;  Project:	mci-emacs-templates
;;  Desc:
;;
;;	Emacs Lisp source
;;
;;  Notes:
;;
;;  Author(s):   Paul Houghton <paul.houghton@mci.com>
;;  Created:	 03/03/01 03:35
;;
;;  Revision Info: (See ChangeLog or cvs log for revision history)
;;
;;	$Author$
;;	$Date$
;;	$Name$
;;	$Revision$
;;	$State$
;;
;;  $Id$
;;


;;;###autoload
(defun find-up-dir (fn &optional start-dir)
  "Search up the path for `fn' and return the path to it
   (i.e. `../..')"
  (interactive)
  (let ((dir (if start-dir start-dir default-directory))
	(updir nil)
	)
    (setq updir (concat dir "/."))
    (while (> (length dir) 1)
      (if (file-exists-p (concat updir "/" fn))
	  (progn
	    (setq updir (file-truename updir))
	    (setq dir "")
	    )
	(progn (setq updir (concat updir "/.."))
	       (let (idx)
		 (setq idx (or (string-match "/" dir) (length dir))
		       dir (substring dir (min (1+ idx)
					       (length dir))))))))
      updir))


(provide 'find-up-dir)

;;;
;;; $Log :$
;;;

;;; Set XEmacs mode
;;;
;;; Local Variables:
;;; mode: Emacs-lisp
;;; End:

