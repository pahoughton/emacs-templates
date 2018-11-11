;; 2013-10-11 (cc) <paul4hough@gmail.com>

(setq load-path (append '("../..") load-path))
(ert-deftest test-template-insert ()
  "validate template-insert function"
  (should (load-file "../../template-insert.el"))
  (add-to-list 'template-dir-list "../..")
  (dolist (tmplfn (directory-files "../.." nil ".tmpl\$" ))
    ;; skip fragments
    (if (not (string-match "-block.tmpl" tmplfn))
	(progn
	  (setq fn (replace-regexp-in-string
		    "default-" "default."
		    (file-name-sans-extension tmplfn)))
	  ;; (message (concat "  provides template for " fn))
	  (setq tbuf (find-file-noselect fn))
	  (switch-to-buffer tbuf)
	  (should (template-insert))
	  ;;(message "%s" (buffer-string))
	  )
      )
    )
  )
