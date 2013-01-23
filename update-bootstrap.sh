#!/bin/bash

ROOT=`pwd`"/vendor/assets"
TMP='tmp/sass-twitter-bootstrap'
# Pull down sass-twitter-bootstrap sources
git clone https://github.com/jlong/sass-twitter-bootstrap.git tmp/sass-twitter-bootstrap
# Copy lib/ to stylesheets/
mkdir -p $ROOT/stylesheets/bootstrap
cp -r $TMP/lib/* $ROOT/stylesheets/bootstrap
# Copy img/ to images/
cp -r $TMP/img/* $ROOT/images
# Remove tests
rm -r $ROOT/stylesheets/bootstrap/tests

# Patch the asset-url in _variables.scss
patch -f vendor/assets/stylesheets/bootstrap/_variables.scss < asseturl.patch

# Patch paths in bootstrap.scss and responsive.scss
sed -i .bak 's_@import \"_@import \"bootstrap/_g' $ROOT/stylesheets/bootstrap/{bootstrap,responsive}.scss
rm $ROOT/stylesheets/bootstrap/*.bak

rm -rf $TMP
# 
TMP='tmp/yui3-gallery'
# Pull down yui3-gallery sources
# git clone --depth=1 git://github.com/yui/yui3-gallery.git tmp/yui3-gallery
git clone --depth=1 git://github.com/jshirley/yui3-gallery.git tmp/yui3-gallery

# Copy js/ to javascripts/
find $TMP/build -name '*.js' | grep bootstrap | grep -v coverage.js | grep -v debug.js | grep -v min.js | while read x ; do cp $x $ROOT/javascripts/ ; done
rm -rf $TMP
