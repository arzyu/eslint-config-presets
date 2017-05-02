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

  version=$(npm version $version_category -m "chore: release v%s")

  ## push master and tag
  git push origin master $version

  ## update dependency and publish
  git_url=$(git remote get-url --push origin)
  github_repo_id=$(dirname $(grep -Eo '[^:/]+/[^/]+$' <<< "$git_url"))/$(basename $git_url .git)
  lerna exec --concurrency 1 "yarn add $github_repo_id#$version --no-progress"; wait
  lerna publish --repo-version ${version:1} --skip-git --yes

  ## commit updated versions and push
  git commit -am "chore: update packages"
  git push origin master

}

release $@
