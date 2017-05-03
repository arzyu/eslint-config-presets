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

echo -n "Change preset name from [$old_preset_name] to: "
read preset_name

if [[ -z $preset_name ]]; then
  die "Nothing to do."
fi

## set word boundary for sed
_bs="\b"
_be="\b"
if ! use_gnu_sed; then
  _bs="[[:<:]]"
  _be="[[:>:]]"
fi

## update README.md and this script
sed -i '' "s;$_bs$old_preset_name$_be;$preset_name;g" \
  README.md scripts/rename-packages-after-fork.sh

## rename packages
for pkg in packages/*; do
  mv "$pkg" "${pkg/$old_preset_name/$preset_name}"
done
