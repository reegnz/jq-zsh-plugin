# jq zsh plugin

Interactively build [jq](https://stedolan.github.io/jq/) expressions
([gojq](https://github.com/itchyny/gojq) is also supported).

This zsh plugin gives you jq superpowers!

## Table of contents

- [Demos](#demos)
- [Installation](#installation)
- [Usage](#usage)
- [Key bindings](#key-bindings)

## Demos

### Interactive jq query construction

[![asciicast](https://asciinema.org/a/IqAqzPS0ZgeaduQ3qs1B5ZgRI.svg)](https://asciinema.org/a/IqAqzPS0ZgeaduQ3qs1B5ZgRI)

### Insert jq query in the middle of a pipeline

[![asciicast](https://asciinema.org/a/9Q4Va21OzD2VTbHwntmLWGvm6.svg)](https://asciinema.org/a/9Q4Va21OzD2VTbHwntmLWGvm6)

## Installation

Besides [jq](https://stedolan.github.io/jq/), this plugin also requires
[fzf](https://github.com/junegunn/fzf#installation) ([a recent version](https://github.com/reegnz/jq-zsh-plugin/issues/19)) to be installed and available on your
PATH.

The following installation methods are proven to work:

* [Oh My Zsh](#oh-my-zsh)
* [zplug](#zplug)
* [Antigen](#antigen)
* [Zgen](#zgen)

### [Oh My Zsh](https://ohmyz.sh)

1. Clone the repository:

```sh
git clone https://github.com/reegnz/jq-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/jq
```

2. Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):

```sh
plugins=(
	# other plugins...
	jq
)
```

3. Start a new terminal session.

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

- type out a command that you expect to produce json on its standard output
- press alt + j
- start typing jq expression and watch it being evaluated in real time (like a true [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)!)
- use up/down and hit tab to select one of the suggestions
- or type out a jq query on your own
- press enter, and the jq expression is appended to your initial command!

## Key bindings

Bringing up the jq query builder for a shell command: `alt + j`

During interactive querying, the following shortcuts can be used:

| Shortcut | Effect |
| ------ | -------- |
| `up` | Navigate path queries |
| `down` | Navigate path queries |
| `tab` | Select path query |
| `shift + up` | Scroll up |
| `shift + down` | Scroll down |
| `alt + up` | Scroll up full page |
| `alt + down` | Scroll down full page |
| `ctrl+r` | Reload input |

## gojq support

If you want to use an alternative `jq` implementation, like
[gojq](https://github.com/itchyny/gojq) then you can override the default jq
command used by the plugin. Set the following environment variable:

```sh
JQ_REPL_JQ=gojq
```

## Internals

The project consists of the following components:

- a `jq.plugin.zsh` providing a [user-defined zsh line-editor
  widget](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html),
  utilizing the `jq-repl` command
- a `jq-repl` command to interactively build jq expressions, utilizing fzf for
  its UI
- a `jq-paths` command to get all valid jq paths in the provided JSON document,
  used for suggesting paths.

## Troubleshooting

### MacOS: Pressing alt-j creates a `∆` symbol in iTerm2

You need to remap your alt-key to `Esc+` in iTerm2:

- `Cmd + ,` to enter preferences
- Go to Profiles
- select your profile from the pane on the left hand side
- go to the keys tab
- Set Left Option (⌥ ) Key to `Esc+`

See other suggestions on stackoverflow if the above one doesn't help you:
https://stackoverflow.com/q/196357/205318

Another option is to map to `ctrl+j` instead by putting this in your `.zshrc`:

```sh
bindkey `^j` jq-complete
```

### Disable expanding shell aliases

The plugin automatically expands shell aliases in a command before passing it
to `jq-repl`. To disable, put the following line into your `.zshrc`:

```sh
JQ_ZSH_PLUGIN_EXPAND_ALIASES=0
```
