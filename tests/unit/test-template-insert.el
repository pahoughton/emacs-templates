(load-file "../../test_tmp/emacs-test-simple/test-simple.el")
(setq debug-on-error t)
(setq load-path (append '("../..") load-path))
(test-simple-start "test for template-insert.el")
(assert-t (load-file "../../template-insert.el")
	  "require template-insert.el failed")
;; have to add topdir to template search path
(add-to-list 'template-dir-list "../..")

(dolist (tmplfn (directory-files "../.." nil ".tmpl\$" ))
  ; skip fragments
  (if (not (string-match "-block.tmpl" tmplfn))
      (progn
	
	(setq fn (replace-regexp-in-string
		  "default-" "default."
		  (file-name-sans-extension tmplfn)))
	(message (concat "  provides template for " fn))
	(setq tbuf (find-file-noselect fn))
	(switch-to-buffer tbuf)
	(assert-t (template-insert)
		  "templaet-insert function returned nil")
	(message "%s" (buffer-string))
	)
    )
  )

(end-tests)
