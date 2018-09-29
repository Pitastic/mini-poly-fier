#!/bin/bash

PWD=`pwd`

# Output leeren
rm -rf $PWD/output/*

echo
echo "--> Compile, Polyfill and Pack (gulp 'n babel)"

# Read filelist for CSS
CONCAT_CSS="["
CSS_FILES="$(find ${PWD}/input/css -name '*.css' -type f)"
for css in $CSS_FILES; do
	CONCAT_CSS+=" '${css}',"
done
CONCAT_CSS+=" ]"

# Read filelist for JS
CONCAT_JS="["
JS_FILES="$(find ${PWD}/input/js -name '*.js' -type f | cut -sd '/' -f6-)"
for js in $JS_FILES; do
	CONCAT_JS+=" '${js}',"
done
CONCAT_JS+=" ]"

# Replacements for filelists in gulpfile.js
echo
echo "Replace file list for AUTO_MODE (css):"
echo "${CONCAT_CSS}"
sed -E -e "s|var cssFiles[[:blank:]]?=[[:blank:]]?AUTO_MODE.*|var cssFiles = ${CONCAT_CSS}|" $PWD/gulpfile.js > /tmp/gulp.tmp && cp /tmp/gulp.tmp $PWD/gulpfile.js

echo
echo "Replace file list for AUTO_MODE (js):"
echo "${CONCAT_JS}"
sed -E -e "s|var jsFiles[[:blank:]]?=[[:blank:]]?AUTO_MODE.*|var jsFiles = ${CONCAT_JS}|" $PWD/gulpfile.js > /tmp/gulp.tmp && cp /tmp/gulp.tmp $PWD/gulpfile.js

# Show IN, start gulp and show OUT
echo
echo "Input:"
tree -sh $PWD/input
echo

gulp

echo
echo "Output:"
tree $PWD/output
echo