#!/bin/bash
# Please note, all the changes should be BEFORE this script
# if the importing PR exists already, the argument has to be true, otherwise false
# PR and Commit name should be the 2nd argument
git config --local user.email "tpe-bot@github.com"
git config --local user.name "Tools Platform Ecosystem bot"
git add .
if git commit -m "bioconda import on $(date)"; then
  if $1; then
    git push
  else
    git checkout -b `$2`-$(date +%s%N | cut -b10-19)
    git push --set-upstream origin "import-$(date +%s%N | cut -b10-19)"
    hub pull-request -m "$2 on $(date)" -l "$2"
  fi
else
  echo "nothing new to add, exiting"
fi