#!/bin/sh

# If a command fails then the deploy stops
set -e

SITE_PATH=~/projects/rolph-recto.github.io

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

rm -rf $SITE_PATH/*
cp -r public/* $SITE_PATH

# Add changes to git.
cd $SITE_PATH
# remove .DS_Store file (thanks Mac)
if test -f .DS_Store; then
	rm .DS_Store
fi
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin HEAD:master
