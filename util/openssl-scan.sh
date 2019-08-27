#!/bin/bash

begin=$(date)

DIR=openssl

if [ ! -d $DIR ]; then
    git clone git@gitlab.com:davxy/openssl.git $DIR
    cd $DIR
    git remote add upstream https://github.com/openssl/openssl.git
    cd ..
fi

# Update local master using upstream
cd $DIR
git checkout master
git pull upstream master

# Push new master to gitlab/master
git push origin master

# Rebase develop to new master
git checkout develop
git merge master

# Push new develop
git push origin develop

# Analyze in docker
docker run -v /home/tsm/openssl/openssl:/openssl -it --rm davxy/sonar-builder /bin/bash -c "cd openssl && ./util/sonar-run.sh"

end=$(date)

echo "Analysis begin: $begin"
echo "Analysis end:   $end"
