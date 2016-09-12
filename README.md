# eslint-config-presets

> Happy coding using multiple config of eslint.

## Try it

### Install

#### presets/default, presets/nodejs, presets/chrome

```bash
npm install --save-dev eslint babel-eslint arzyu/eslint-config-presets
```

#### presets/angular

```bash
npm install --save-dev eslint babel-eslint eslint-plugin-angular eslint-config-angular arzyu/eslint-config-presets
```

#### presets/react

```bash
npm install --save-dev eslint babel-eslint eslint-plugin-react arzyu/eslint-config-presets
```

#### presets/react-native

```bash
npm install --save-dev eslint babel-eslint eslint-plugin-react eslint-plugin-react-native arzyu/eslint-config-presets
```

### Use presets

There are 2 ways to use these presets:

1. Create a eslint config file (e.g. `.eslintrc.yml`) on top level of your project.

	```yaml
	---
	# All available presets:
	#   `presets/default`, or use `presets` for short
	#   `presets/nodejs`
	#   `presets/angular`
	#   `presets/react`
	#   `presets/react-native`
	#   `presets/chrome`

	extends: presets/react
	```

2. Add `eslintConfig` option to `package.json`.

	```json
	{
	  "eslintConfig": {
		"extends": "presets/angular"
	  }
	}
	```

## Fork it

These are mine config files. They may not meet all your specific needs.
I recommend you **fork** it and do the appropriate adjustments to fit your needs.

After forking this repository, you can also rename it by running `./rename-preset.sh`.

```
arzyu/eslint-config-presets => {GITHUB_USER}/eslint-config-{PRESET_NAME}
```

