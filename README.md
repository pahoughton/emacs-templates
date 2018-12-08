## emacs-templates

[![Test Build Status](https://travis-ci.org/pahoughton/emacs-templates.png)](https://travis-ci.org/pahoughton/emacs-templates)

emacs-templates uses elisp and tempalte files to insert a template
into the current buffer base on the file name or buffers mode. works
for both GNU emacs and xemacs.

## Usage

Add these to your emacs init (using whatever key you wish)

    # for emacs
    (global-set-key (kbd "<M-f5>")	'template-insert)
    # for xemacs
    (define-key global-map '(meta f5)   'template-insert)

## Features

Templates for:
* .fixtures.yml
* .travis.yml
* Makefile.am
* Makefile
* README.md
* configure.ac
* main.C
* *.C
* *.c
* *.cpp
* *.dtd
* *.el
* *.h
* *.hh
* *.hm
* *.ii
* *.java
* *.m
* *.php
* *.pl
* *.pm
* *.pp
* *.py
* *.sql
* *.tmpl
* *.txt
* *.xml
* *.xsl
* *.yml

See [Travis](https://travis-ci.org/pahoughton/emacs-templates) console
output for examples

## Contribute

https://github.com/pahoughton/emacs-templates

## License
1995-11-13 (cc)  Paul Houghton <paul4hough@gmail.com>

[![LICENSE](http://i.creativecommons.org/l/by/4.0/80x15.png)](http://creativecommons.org/licenses/by/4.0/)
