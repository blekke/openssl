#!/bin/bash

INC="-I. -Iinclude -Icrypto/include"

SRC=$1
if [ "$SRC" == "" ]; then
    SRC="crypto"
fi

rm -rf sonar-data
mkdir sonar-data

# CPPcheck: a general purpose static code checker
echo "Running cppcheck on $SRC ..."
cppcheck -Dinline=inline --language=c --force --enable=all --suppress=variableScope --suppress=unusedFunction --suppress=missingIncludeSystem --xml $INC $SRC 2> sonar-data/cppcheck-report.xml

# Vera++: static code checker focusing on style issues
VERA_SKIP="T0(10|11|12|13|19)"
echo "Running vera++ on $SRC ..."
find $SRC include -type f -regextype sed -iregex ".*/*\.\(c\|h\)" -print | vera++ - -showrules -nodup 2> vera.tmp
cat vera.tmp | grep -v -E $VERA_SKIP | util/vera2report.perl > sonar-data/vera-report.xml
rm vera.tmp

