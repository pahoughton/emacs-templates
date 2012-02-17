;;
;;  File:	template-insert.el
;;  Project:	EmacsTemplates
;;  Desc:
;;
;;	Insert a template into the current buffer.
;;  
;;  Notes:
;;    
;;  Author(s):   Paul Houghton <pahoughton@users.sourceforge.net>
;;  Created:     08/17/2001 13:20
;;  
;;  Revision History: (See ChangeLog for Details
;;  
;;	$Author$
;;	$Name$
;;	$Date$
;;	$Revision$
;;	$State$
;;
;;  $Id$
;;

(require 'template-insert-config)
(require 'string)

(defgroup templates nil
  "A package for inserting templates based on file or major mode."
  :group 'editing)

(defcustom template-dir-list
  (list "." "./.templates" "~/.templates" template-insert-tmpl-dir)
  "*A list of direcotries to search for template files in"
  :group 'templates
  :type '(repeat directory))

(defcustom template-ext ".tmpl"
  "*The default extention to use for template files."
  :group 'templates
  :type 'string)

(defcustom template-ver-mgmt 'cvs
  "Version management tags to use"
  :group 'templates
  :type '(choice (const :tag "CVS" cvs)
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

    file-name
    email
    timestamp

Helper functions
    `template-ver-string'
    `template-get-project-name'

"
  (interactive)
  (let* ( (file-name (file-name-nondirectory (buffer-file-name)))
	  (tmpl (template-find-tmpl file-name))
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
	  (template-insert-file tmpl)
	  )
      (error 'file-error (list (concat "Could not find default-txt"
				       template-ext)
			       "in"
			       template-dir-list)))
    )
  )

(defun template-insert-fragment (tmpl)
  "Insert the contents 'tmpl' as part of a template"
  (let* ( (tmpl-file (locate-file tmpl template-dir-list))
	  (tmp-buf nil)
	  )
    (if tmpl-file
	(let* ( (frag-string nil) )
	  (save-excursion
	    (setq tmp-buf (generate-new-buffer "*template temp*"))
	    (set-buffer tmp-buf)
	    (template-insert-file tmpl-file)
	    (setq frag-string (buffer-string))
	    (kill-buffer tmp-buf)
	    )
	  frag-string)
      (error 'file-error (list "Could not find "
			       tmpl
			       "in"
			       template-dir-list))))
  )
  
(defun template-insert-file (tmpl-file)
  "Insert the evaluated contents of the file 'tmpl-file' into the
current buffer."
  (let* ( (email (concat "<" (user-mail-address) ">" ))
	  (file-base-name (file-name-sans-extension file-name))
	  (file-ext (file-name-extension file-name))
	  (timestamp (format-time-string "%m/%d/%Y %R"))
	  (copyright (if (getenv "COPYRIGHT")
			 (concat "Copyright (c) "
				 (format-time-string "%Y ")
				 (getenv "COPYRIGHT"))
		       ""))
	  (tmp-buf nil)
	  )
    (save-excursion
      (setq tmp-buf (generate-new-buffer "*template temp*"))
      (set-buffer tmp-buf)
      (insert-file-contents tmpl-file))
    
    (eval-buffer tmp-buf)
    (kill-buffer tmp-buf)))

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
