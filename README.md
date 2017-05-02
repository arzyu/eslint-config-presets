# eslint-config-presets

> Happy coding using multiple configurations of eslint.

## Try it

### Select and install one of these presets

```bash
## install default preset
yarn add -D eslint-config-arzyu

## install nodejs preset
yarn add -D eslint-config-arzyu-nodejs

## install chrome preset
yarn add -D eslint-config-arzyu-chrome

## install angular preset
yarn add -D eslint-config-arzyu-angular

## install react preset
yarn add -D eslint-config-arzyu-react

## install react-native preset
yarn add -D eslint-config-arzyu-react-native
```

### Use preset

There are two ways to use a preset.

Suppose you have installed `eslint-config-arzyu-react`, and then:

Add `eslintConfig` option to `package.json`:

```json
{
  "eslintConfig": {
    "extends": "arzyu-react"
  }
}
```

or Create a eslint config file (e.g. `.eslintrc.yml`) on top level of your project:

```yaml
extends: arzyu-react
```

## Fork it

These are mine config files. They may not meet all your specific needs.
I recommend you **fork** it and do the appropriate adjustments to fit your needs.
