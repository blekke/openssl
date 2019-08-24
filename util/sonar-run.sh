#!/bin/bash

<<<<<<< HEAD
INC="-I.. -I../include -I../crypto/include"

SRC=$1
if [ "$SRC" == "" ]; then
    SRC="../crypto/aes/"
fi

rm -rf sonar-data
=======
INC="-I ../include -I../crypto/include"
SRC=../crypto

>>>>>>> bda35698783cbca8fa92a7ca09c5b9e2cc11a1ce
mkdir sonar-data

# CPPcheck: a general purpose static code checker
echo "Running cppcheck ..."
<<<<<<< HEAD
cppcheck -Dinline=inline --language=c --force --enable=all --suppress=variableScope --suppress=unusedFunction --suppress=missingIncludeSystem --xml $INC $SRC 2> sonar-data/cppcheck-report.xml

cppcheck-htmlreport --title=OpenSSL --file=sonar-data/cppcheck-report.xml --report-dir=sonar-data/html
=======
cppcheck --language=c --std=c89 --force --enable=all --suppress=variableScope --suppress=unusedFunction --suppress=missingIncludeSystem --xml $INC $SRC 2> sonar-data/cppcheck-report.xml
>>>>>>> bda35698783cbca8fa92a7ca09c5b9e2cc11a1ce
