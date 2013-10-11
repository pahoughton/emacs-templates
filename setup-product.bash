#!/bin/bash
# File:		setup-product.bash
# Project:	product-setup
#
#   The product setup product provides for installing any dependencies.
#
# Author(s):   Paul Houghton <paul4hough@gmail.com>
# Created:     07/05/2003 07:39
#
# FIXME - next release
# [ -d p.setup ] || mkdir p.setup
# cd p.setup
# grep /p.setup .gitignore > /dev/null || echo /p.setup >> .gitignore
# git clone https://github.com/pahoughton/product-setup
# bash product-setup/bin/setup-product.bash
apt-get install emacs23
apt-get install autoconf
touch .setup-product.stamp
