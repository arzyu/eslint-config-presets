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

  last_release_version="$(cat lerna.json | grep '"version"' | cut -d '"' -f 4)"
  local_package_version="$(cat package.json | grep '"version"' | cut -d '"' -f 4)"

  ## test whether a new version exists
  if [[ "$local_package_version" != "$last_release_version" ]]; then
    version=$(printf "$last_release_version\n$local_package_version" \
              | sort -t. -k 1,1nr -k 2,2nr -k 3,3nr | head -1)

    if [[ "$version" != "$local_package_version" ]]; then
      die "Error: unexpected version in package.json."
    fi
  else
    version=$(npm version $version_category -m "chore: release v%s")

    ## push master and tag
    git push origin master $version
  fi

  ## update dependency and publish
  git_url=$(git remote get-url --push origin)
  github_repo_id=$(dirname $(grep -Eo '[^:/]+/[^/]+$' <<< "$git_url"))/$(basename $git_url .git)
  $(npm bin)/lerna exec --concurrency 1 "yarn add $github_repo_id#$version --no-progress"; wait
  $(npm bin)/lerna publish --repo-version ${version:1} --skip-git --yes

  ## commit updated versions and push
  git commit -am "chore: update packages"
  git push origin master

}

release $@
