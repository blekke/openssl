#!/bin/bash

DIR=openssl

# Exit on first error
set -e

if [ ! -d $DIR ]; then
    git clone git@gitlab.com:davxy/openssl.git $DIR
    cd $DIR
    git remote add upstream https://github.com/openssl/openssl.git
    cd ..
    do_stash=0
else
    do_stash=1
fi

cd $DIR

# Stash pending changes
if [ $do_stash == 1 ]; then
    echo "Stashing"
    git stash
fi

# Update local master using upstream
git checkout master
git pull upstream master

# Update local develop using origin
git checkout develop
git pull origin develop

# Merge master to develop
git merge --no-edit master

# Push new stuff
git push origin master
git push origin develop

# Unstash changes
if [ $do_stash == 1 ]; then
    echo "Unstashing"
    git stash pop
fi

# Disable exit on first error
set +e
