#! /bin/bash

set -e

echo "This script will help you rename:"
echo "  arzyu/eslint-config-presets => <GITHUB_USER>/eslint-config-<PRESET_NAME>"
echo
echo -n "Enter <GITHUB_USER>: "
read github_user
echo -n "Enter <PRESET_NAME>: "
read preset_name
echo

if [[ -z $github_user || -z $preset_name ]]; then
	echo "Nothing to do."
	exit 1;
fi

sed -i '' \
	-e "s;presets/;$preset_name/;g" \
	-e "s;\`presets\`;\`$preset_name\`;g" \
	-e "s;eslint-config-presets;eslint-config-$preset_name;g" \
	-e "s;arzyu/eslint-config-;$github_user/eslint-config-;g" \
	`find . -type f -not -path ./.git\*`

