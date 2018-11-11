;; 2001-03-03 (cc) <paul4hough@gmail.com>
;; Find fn in parent directory

;;;###autoload
(defun find-up-dir (fn &optional from-dir)
  "Search up the path for `fn' and return the path to it
   (i.e. `../..')"
  (interactive)
  (let ((dir (file-truename (if from-dir from-dir  default-directory)))
	(found-dir nil)
	)
    (setq dir (replace-regexp-in-string "/$" "" dir))
    (while (and (not found-dir) (> (length dir) 1))
      (if (file-exists-p (concat dir "/" fn))
	  (setq found-dir dir)
	(setq dir (substring (file-name-directory dir) 0 -1))))
    found-dir))

(provide 'find-up-dir)
