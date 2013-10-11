;; test-template-insert-sys.el - 2013-10-11 12:46
;;
;; Copyright (c) 2013 Paul Houghton <paul4hough@gmail.com>

(setq debug-on-error t)
(if (string-match "XEmacs\\|Lucid" emacs-version)
    (setq dotedir (concat (getenv "HOME") "/.xemacs"))
  (setq dotedir (concat (getenv "HOME") "/.emacs.d")))

(add-to-list 'load-path (concat dotedir "/lisp"))
(setq cwd default-directory)
(setq default-directory (concat dotedir "/lisp"))
(add-to-list 'load-path (normal-top-level-add-subdirs-to-load-path))
(setq default-directory cwd)
(load (concat dotedir "/lisp/loaddefs"))

(setq fn "test-sys-temp.py")
(message (concat "  provides template for " fn))
(setq tbuf (find-file-noselect fn))
(switch-to-buffer tbuf)
(template-insert)
(message "Results: %s" (buffer-string))
