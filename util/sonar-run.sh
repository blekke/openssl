#!/bin/bash

INC="-I. -Iinclude -Icrypto/include"

SRC=$1
if [ "$SRC" == "" ]; then
    SRC="crypto"
fi

rm -rf sonar-data
mkdir sonar-data

# CPPcheck: a general purpose static code checker
echo "Running cppcheck on $SRC..."

cppcheck -Dinline=inline --language=c --force --enable=all --suppress=variableScope --suppress=unusedFunction --suppress=missingIncludeSystem --xml $INC $SRC 2> sonar-data/cppcheck-report.xml

cppcheck-htmlreport --title=OpenSSL --file=sonar-data/cppcheck-report.xml --report-dir=sonar-data/html
