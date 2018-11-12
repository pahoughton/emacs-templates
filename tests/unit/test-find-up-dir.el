;; 2018-11-11 (cc) <paul4hough@gmail.com>

(ert-deftest test-find-up-dir ()
  "validate find-up-dir function"
  (should (load-file "../../find-up-dir.el"))
  (let ((pat "found")
	(fpath (concat (file-truename default-directory) ".testing/dira"))
	(spath nil))
    (setq spath (concat fpath "/" pat "/db/dirc"))
    (make-directory spath 1)
    (should (equal (find-up-dir pat (concat fpath "/" pat)) fpath))
    (should (equal (find-up-dir pat spath) fpath))
    (should (cd fpath))
    (should (equal (find-up-dir pat) fpath))
    (should (cd spath))
    (should (equal (find-up-dir pat) fpath))
    (should (eql (find-up-dir "not likely to find") nil))
    ))
