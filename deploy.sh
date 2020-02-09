#!/bin/sh

# If a command fails or variable is undefined then the deploy stops
set -eu

# Define directory containing the git submodule for the deployed build:
PUBLIC='public'

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd ${PUBLIC}

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
# Echo here is mainly to avoid early termination of the script - "git commit"
# returns exit code of 1 if there's no changes to commit (despite it not being
# an error).
git commit -m "$msg" || echo "no changes needed to be committed"

# Push source repo:
cd -
git push -v origin master
# And push deployed repo:
cd ${PUBLIC}
git push -v origin master
cd -
