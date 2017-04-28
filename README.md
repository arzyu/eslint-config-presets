# eslint-config-presets

> Happy coding using multiple configurations of eslint.

## Try it

### Select and install one of these presets

```bash
## install default preset
npm install --save-dev eslint-config-arzyu

## install nodejs preset
npm install --save-dev eslint-config-arzyu-nodejs

## install chrome preset
npm install --save-dev eslint-config-arzyu-chrome

## install angular preset
npm install --save-dev eslint-config-arzyu-angular

## install react preset
npm install --save-dev eslint-config-arzyu-react

## install react-native preset
npm install --save-dev eslint-config-arzyu-react-native
```

### Use preset

Suppose you have installed `eslint-config-arzyu-react`.

There are two ways to use a preset:

1. Add `eslintConfig` option to `package.json`.

	```json
	{
	  "eslintConfig": {
	    "parser": "babel-eslint",
	    "extends": "arzyu-react"
	  }
	}
	```

2. Create a eslint config file (e.g. `.eslintrc.yml`) on top level of your project.

	```yaml
	parser: babel-eslint
	extends: arzyu-react
	```

## Fork it

These are mine config files. They may not meet all your specific needs.
I recommend you **fork** it and do the appropriate adjustments to fit your needs.

After forking this repository, you can also rename it by running `./rename-preset.sh`.

```
arzyu/eslint-config-presets => {GITHUB_USER}/eslint-config-{PRESET_NAME}
```
