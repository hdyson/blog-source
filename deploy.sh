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
git commit -m "$msg"

# Push source repo:
cd -
git push origin master
# And push deployed repo:
cd ${PUBLIC}
git push origin master
cd -
