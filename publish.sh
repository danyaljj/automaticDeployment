#!/bin/bash

set -e

# Publish to BinTray if the HEAD commit is tagged with a version number.
if [ "$PULL_REQUEST_NUMBER" ]; then
  echo "Semaphore is building a pull request, not publishing."
  echo "PULL_REQUEST_NUMBER is equal to $PULL_REQUEST_NUMBER"
  exit 0
fi

if [ "$BRANCH_NAME" != "master" ]; then
  echo "Semaphore is building on branch $BRANCH_NAME, not publishing."
  echo "BRANCH_NAME is equal to $BRANCH_NAME"
  exit 0
fi

numParents=`git log --pretty=%P -n 1 | wc -w | xargs`
if [ $numParents -ne 2 ]; then
  echo "$numParents parent commits of HEAD when exactly 2 expected, not publishing."
  exit 0
fi

# change the version number 
bash increment-pom-versions.sh

# setup the authentication required for deploy
# start the ssh-agent in the background
eval "$(ssh-agent -s)"
ssh-add /home/runner/.ssh/ai2

# add to the known hosts 
# ssh-keygen -R bilbo.cs.illinois.edu
# ssh-keyscan -t rsa,dsa bilbo.cs.illinois.edu 2>&1 | sort -u - ~/.ssh/known_hosts > ~/.ssh/tmp_hosts
# mv ~/.ssh/tmp_hosts ~/.ssh/known_hosts
ssh-keyscan -H -p 22 bilbo.cs.illinois.edu >> ~/.ssh/known_hosts

# going to deploy, without testing (since we should have tested earlier, before running the "publish.sh" script) 
mvn deploy -Dmaven.test.skip=true

# commit changes and push them to the repo
git config --global user.email "khashab2@illinois.edu"
git config --global user.name "SemaphoreCI"
git add pom.xml 
git commit -m 'automatic version increment'
git push origin master 
