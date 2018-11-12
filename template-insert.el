;;
;;  File:	template-insert.el
;;  Project:	emacs-templates
;;  Desc:
;;
;;	Insert a template into the current buffer.
;;
;;  Author(s):   Paul Houghton <paul4hough@gmail.com>
;;  Created:     08/17/2001 13:20
;;

(require 'template-insert-config)
(require 'find-up-dir)

(defgroup templates nil
  "A package for inserting templates based on file or major mode."
  :group 'editing)

(defcustom template-travis-user "pahoughton"
  "*Default travis user id for README.md"
  :group 'templates
  :type 'string)

(defcustom template-coderwall-user "pahoughton"
  "*Default coderwall user id for README.md"
  :group 'templates
  :type 'string)

(defcustom template-github-user "pahoughton"
  "*Default github user id for README.md"
  :group 'templates
  :type 'string)


(defcustom template-dir-list
  (list "." "./.templates" "~/.templates" template-insert-tmpl-dir)
  "*A list of direcotries to search for template files in"
  :group 'templates
  :type '(repeat directory))

(defcustom template-ext ".tmpl"
  "*The default extention to use for template files."
  :group 'templates
  :type 'string)

(defcustom template-ver-mgmt 'git
  "Version management tags to use"
  :group 'templates
  :type '(choice (const :tag "git" git)
		 (const :tag "CVS" cvs)
		 (const :tag "Dimensions" dim)))

(defcustom template-fn-tmpl-alist nil
  "Assoicated list of complete file names to template file names. The
`template-dir-list' is searched for the template file specified."
  :group 'templates
  :type '(repeat (cons :tag "Mapping" string string)))

(defcustom template-ext-tmpl-alist nil
  "Assoicated list of file extentions to template file names. The
`template-dir-list' is searched for the template file specified."
  :group 'templates
  :type '(repeat (cons :tag "Mapping" string  string)))

(defcustom template-ext ".tmpl"
  "The extintion to use for template files"
  :group 'templates
  :type  'string )

(defconst template-ver-strings
      '( (cvs . (
		 (project	. "")
		 (item		. "")
		 (author	. (concat "$" "Author: $"))
		 (tag		. (concat "$" "Name:" "$"))
		 (date		. (concat "$" "Date: $"))
		 (version	. (concat "$" "Revision: $"))
		 (state		. (concat "$" "State: " "$"))
		 (id		. (concat "$" "Id: " "$"))
		 (log		. (concat "$" "Log: $"))
		 ))
	 (dim . (
		 (project	. (concat "%" "PP" "%"))
		 (item		. (concat "%PI% (%PF%)"))
		 (author	. (concat "%PO%"))
		 (tag		. "")
		 (date		. (concat "%PRT%"))
		 (version	. (concat "%PIV%"))
		 (state		. (concat "%PS%"))
		 (id		. (concat "%PID%"))
		 (log		. (concat "%PL%")))))
      )


(defvar template-history nil
  "This is the minibuffer history for the insert-template funtion." )

(defvar template-project-name-history nil
  "This is the minibuffer history for the get-project-name function.")

(defvar template-doc-desc nil
  "The doc desc to use" )

(defun template-get-project-name ()
  "Ask the use for a project name and return the string"
  (read-from-minibuffer "Enter Project name: "
			(car template-project-name-history)
			nil nil
			'template-project-name-history))

(defun template-ver-string ( key &optional vermgmt )
  "Return the `author' keyword for the version management software"
  (interactive)
  (let ((ver (or vermgmt template-ver-mgmt)))
    (eval (cdr (assoc key (assoc ver template-ver-strings))))
  ))

;;;###autoload
(defun template-insert-template-dir ()
  "Return the installation template directory"
  (concat template-insert-tmpl-dir))

;;;###autoload
(defun template-insert ()
  "Insert a template into the current buffer accoding to the buffer
\(file\) name or mode.

Helper vars:

    file-base-name
    file-ext
    email
    timestamp
    copyright

Helper functions
    `template-ver-string'
    `template-get-project-name'

"
  (interactive)
  (let* ( (buf-file-full-name (buffer-file-name))
	  (tmpl (template-find-tmpl
		 (file-name-nondirectory buf-file-full-name)))
	  )
    (if (not tmpl)
	(let* ( (txt-tmpl (locate-file (concat "default-txt"
					       template-ext)
				       template-dir-list)))
	  (if txt-tmpl
	      (progn
		(setq tmpl (read-from-minibuffer
			    "Enter template file to insert: "
			    txt-tmpl
			    ))))))
    (if tmpl
	(progn
	  (setq template-doc-desc nil)
	  (template-insert-file tmpl buf-file-full-name)
	  )
      (error  (concat "Could not find default-txt"
		      template-ext
		      " in "
		      (prin1-to-string template-dir-list))))
    )
  )


(defun template-insert-fragment (tmpl)
  "Insert the contents 'tmpl' as part of a template"
  (let* ( (tmpl-file (locate-file tmpl template-dir-list))
	  (tmp-buf nil)
	  )
    (if tmpl-file
	(progn

	  (message (concat "Inserting template fragment: " tmpl-file))
	  (let* ( (frag-string nil)
		  (buf-file-full-name (buffer-file-name))
		  )
	    (save-excursion
	      (setq tmp-buf (generate-new-buffer "*template frag temp*"))
	      (set-buffer tmp-buf)
	      (template-insert-file tmpl-file buf-file-full-name)
	      (setq frag-string (buffer-string))
	      (kill-buffer tmp-buf)
	      )
	    frag-string)
	  )
      (error (concat "Could not find "
		     tmpl
		     " in "
		     (prin1-to-string template-dir-list)))))
  )

(defun template-product-dir-name (full-fn)
  "find and return the product's top level directory name.

given template-ver-mgmt is git then look for .git directory
given not found yet then look for one of the files configure.ac,
LICENSE, README.md and README.
"
  (let* ( (top-file-list '(".git" "configure.ac"
			   "LICENSE" "README.md" "README"))
	  (iter 0)
	  (found-dir nil)
	  )
    (while (and (not found-dir) (elt top-file-list iter))
      ;; (message "fn %d - %s" iter (elt top-file-list iter))
      (setq found-dir (find-up-dir (elt top-file-list iter) full-fn))
      (setq iter (+ iter 1))
      )
    (if (not found-dir)
	(setq found-dir (substring (file-name-directory full-fn) 0 -1)))
    found-dir
    ))

(defun template-insert-file (tmpl-file buf-file-full-name)
  "Insert the evaluated contents of the file 'tmpl-file' into the
current buffer."
  (let* ( (email (concat "<" user-mail-address ">" ))
	  (file-name (file-name-nondirectory buf-file-full-name))
	  (file-base-name (file-name-sans-extension file-name))
	  (file-ext (file-name-extension file-name))
	  (product-dir-name (file-name-nondirectory
			     (template-product-dir-name buf-file-full-name)))
	  (timestamp (format-time-string "%Y-%m-%d"))
	  (copyright (if (getenv "COPYRIGHT")
			 (concat " (cc) " (getenv "COPYRIGHT"))
		       (concat "(cc) " email )))
	  (tmp-buf nil)
	  )
    (message (concat "Inserting template: " tmpl-file))
    (save-excursion
      (setq tmp-buf (generate-new-buffer "*template temp*"))
      (set-buffer tmp-buf)
      (insert-file-contents tmpl-file))

    (eval-buffer tmp-buf)
    (kill-buffer tmp-buf)
    (goto-char (point-max))
    ))

(defun template-find-tmpl (file-name)
  "Find the template for a file"
  (let* ((tmpl-file nil)
	 (file-ext (file-name-extension file-name))
	 (fn-tmpl  (cdr (assoc file-name template-fn-tmpl-alist)))
	 (ext-tmpl (cdr (assoc file-ext template-ext-tmpl-alist)))
	 )
    (cond
     (fn-tmpl
      (setq tmpl-file (locate-file fn-tmpl template-dir-list))
      )
     (ext-tmpl
      (setq tmpl-file (locate-file ext-tmpl template-dir-list))
      )
     (t
      (setq tmpl-file
	    (or (locate-file (concat file-name template-ext)
			     template-dir-list)
		(locate-file (concat "default-"
				     (file-name-extension
				      file-name)
				     template-ext)
			     template-dir-list)))
      )
     )
    tmpl-file))

(provide 'template-insert)
