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

See [Travis](https://travis-ci.org/pahoughton/emacs-templates) console
output for examples

## License
1995-11-13 (cc)  Paul Houghton <paul4hough@gmail.com>

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/">
<img alt="Creative Commons License" style="border-width:0"
src="https://i.creativecommons.org/l/by/4.0/80x15.png" />
</a>
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/">
Creative Commons Attribution 4.0 International License</a>.
