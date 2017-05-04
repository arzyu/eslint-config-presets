#!/bin/bash

set -e

function die() {
  echo "$@" >&2; exit 1
}

function use_gnu_sed() {
  if [[ -n "$(sed --version 2>/dev/null | head -n 1 | grep GNU)" ]]; then
    true
  else
    false
  fi
}

old_preset_name="arzyu"

cd "$(dirname "$0")/.."

echo -n "=> Where to host ? Enter a GitHub username/organization: "
read github_user

if [[ -z $github_user ]]; then
  die "Need GitHub username."
fi

echo "=> Rename [packages/eslint-config-$old_preset_name-*] to [packages/eslint-config-(?)-*]"
echo -n "(default: $github_user): "
read preset_name

if [[ -z $preset_name ]]; then
  preset_name="$github_user"
fi

## set for sed
_infile="-i"
_regex="-r"
_bs="\b"
_be="\b"
if ! use_gnu_sed; then
  _infile="-i ''"
  _regex="-E"
  _bs="[[:<:]]"
  _be="[[:>:]]"
fi

## update README.md and this script
sh -c "sed $_infile \"s;$_bs$old_preset_name$_be;$preset_name;g\" \
  README.md scripts/rename-packages-after-fork.sh"

# update packages/*/package.json
find packages -regex "packages/[^/]*/package.json" \
  -exec sh -c "sed $_infile $_regex \
    -e '/\"name\"/ s;$old_preset_name;$preset_name;' \
    -e 's;[^\"/]+/eslint-config-presets;$github_user/eslint-config-presets;' \
    {}" ";"

## rename packages
for pkg in packages/*; do
  mv "$pkg" "${pkg/$old_preset_name/$preset_name}"
done

echo "=> done."
