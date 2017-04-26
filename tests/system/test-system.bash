#
# File:	    test-system.bash
# Project:  emacs-utils
# Desc:
#
#   Perform system tests for emacs-utils product
#
# Author(s):   Paul Houghton <paul4hough@gmail.com>
# Created:     2013-10-08 11:12
#

#set -x
product_dir="emacs-templates"

topdir=$1
if [ -z "$topdir" ] ; then
    echo "Need topdir"
    exit 2
fi

results=0

# Setup and install into testing dir
cd "${topdir}"
[ -d "test_tmp/${product_dir}"* ] && rm -rf "test_tmp/${product_dir}"*
make dist
cd test_tmp
[ -d test_home ] && rm -rf test_home
mkdir test_home
TEST_HOME=`pwd`/test_home

tar xf "../${product_dir}"*tar.gz
cd "${product_dir}"*
HOME="${TEST_HOME}"
autoreconf &&
./configure --with-lispdir="${TEST_HOME}/.emacs.d/lisp" &&
make install || exit 1
# double install works? (had a bug w/ this b4)
make install || exit 1
results=0
echo "Feature: emacs-templates"

# good for debuging
# emacs -batch -l "${HOME}/.emacs.d/init.el" -eval '(princ load-path)'

tfn=test-template-sys.out
emacs -batch --load tests/system/test-template-insert-sys.el > "${tfn}" 2>&1
cat "${tfn}"
if grep 'class test-sys-temp' "${tfn}" && \
    grep '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]' \
       "${tfn}" ; then
  echo " provides .py template."
else
  echo " FAILED to provide .py template."
  results=1
fi

exit $results
