#!/usr/bin/env bash
# One-time setup: initialize git, create the develop branch, and push to a new
# GitHub repo. Requires the GitHub CLI (`gh`) to be installed and authenticated
# (`gh auth login`) — or skip the `gh repo create` line and create the repo
# manually on github.com first, then just run the git commands below.

set -e

REPO_NAME="meridian-systems"
VISIBILITY="private"   # change to "public" if needed

git init
git add .
git commit -m "chore: initial repo scaffold (modules, docs, CI, templates)"
git branch -M main

# Create the repo on GitHub and push (requires `gh` CLI)
gh repo create "$REPO_NAME" --"$VISIBILITY" --source=. --remote=origin --push

# Create and push the develop branch
git checkout -b develop
git push -u origin develop

# Set main as the default protected branch, develop as the working integration branch.
# Branch protection rules (require PR + passing CI + code owner review) must be set
# in GitHub Settings > Branches — the API call for this depends on your plan
# (protection rules are limited on some free-tier private repos).
echo "Done. Set branch protection on 'main' and 'develop' in:"
echo "  https://github.com/<your-org>/$REPO_NAME/settings/branches"
echo "Then sync labels from .github/labels.yml (manually, or with a label-sync action)."
