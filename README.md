# jq zsh plugin

Interactively build [jq](https://stedolan.github.io/jq/) expressions.

This zsh plugin gives you jq superpowers!

## Table of contents

- [Installation](#installation)
- [Usage](#usage)
- [Key bindings](#key-bindings)
- [Demos](#demos)
  - [Interactive jq query construction](#interactive-jq-query-construction)
  - [Insert jq query in the middle of a pipeline](#insert-jq-query-in-the-middle-of-a-pipeline)

## Installation

This plugin requires [fzf](https://github.com/junegunn/fzf) to be available
on your PATH.

The project consists of two components:
- a `jq-repl` command
- a `jq.plugin.zsh` providing line-editor feature using `jq-repl`


### [zplug](https://github.com/zplug/zplug)

```sh
zplug reegnz/jq-zsh-plugin
```

### [Antigen](https://github.com/zsh-users/antigen)

```sh
antigen bundle reegnz/jq-zsh-plugin
```

### [Zgen](https://github.com/tarjoilija/zgen)

```sh
zgen load reegnz/jq-zsh-plugin
```

## Usage

- type out a command that you expect to produce json on it's standard output
- press alt + j and interactively write a jq expression
- press enter, and the jq expression is appended to your initial command!

## Key bindings

To bring up the JQ query builder, press `alt + j`.

During interactive querying, the following shortcuts can be used:

| Shortcut | Effect |
| ------ | -------- |
| `shift + up` | Scroll up |
| `shift + down` | Scroll down |
| `alt + up` | Scroll up full page |
| `alt + down` | Scroll down full page |

## Demos

### Interactive jq query construction

[![asciicast](https://asciinema.org/a/296765.svg)](https://asciinema.org/a/296765)

### Insert jq query in the middle of a pipeline

[![asciicast](https://asciinema.org/a/296767.svg)](https://asciinema.org/a/296767)

## Troubleshooting

### Pressing alt-j creates a `∆` symbol in iTerm2

    Cmd + , to enter preferences
    Go to Profiles, select your profile from the pane on the left hand side, then go to the keys tab.
    Set Left Option (⌥) Key to Esc+
