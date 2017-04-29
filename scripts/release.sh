#!/bin/bash

set -e

function die() {
  echo "$@" >&2; exit 1
}

function release() {
  ## check working tree status
  if [[ -n "$(git status --porcelain)" ]]; then
    die "Error: Working tree *MUST* clean."
  fi

  version_category="$1"

  case $1 in
    major | minor | patch ) ;;
    * ) die "Error: Need version category: major, minor or patch.";;
  esac

  version=$(npm version $version_category --no-git-tag-version)

  ## create tag and push
  git tag $version
  git push origin master $version

  ## update dependency and publish
  git_url=$(git remote get-url --push origin)
  github_repo_id=$(dirname $(grep -Eo '[^:/]+/[^/]+$' <<< "$git_url"))/$(basename $git_url .git)
  lerna exec yarn add "$github_repo_id#$version" --no-progress
  lerna publish --cd-version $version_category --yes --skip-git

  ## commit updated versions and push
  git commit -am "chore: release packages $version"
  git push origin master
}

release $@
