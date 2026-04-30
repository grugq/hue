# `hue` — Specification

A theme manager for `zsh-syntax-highlighting`. Provides a curated set of light and dark themes drawn from established colour schemes (Solarized, Gruvbox, Nord, Tokyo Night, Catppuccin, etc.), a CLI to select among them, and shell integration for runtime switching and automatic light/dark adaptation.

Modeled loosely on `vivid` (which does the same job for `LS_COLORS`).

---

## Goals

1. Single self-contained script installable to `~/.local/bin/hue`, no runtime dependencies beyond zsh itself.
2. Themes are data files, not code. Adding a theme is dropping a file in a directory.
3. Output is a block of `typeset -gA ZSH_HIGHLIGHT_STYLES=(...)` that the user evals before sourcing the plugin, mirroring `eval "$(vivid generate <theme>)"`.
4. Ships with 10–15 curated themes covering the common palettes in both light and dark variants.
5. Reasonable behaviour on missing themes, malformed files, and unsupported terminals.

## Non-goals

- No GUI, no TUI picker (a simple `--list` is enough; fzf integration is the user's problem).
- No support for highlighters other than the `main` highlighter from `zsh-syntax-highlighting`. The `brackets`, `pattern`, `cursor`, `regexp`, `root`, and `line` highlighters use the same `ZSH_HIGHLIGHT_STYLES` array, so they get covered for free where keys overlap, but tuning them is out of scope for v1.
- No conversion from other theme formats (base16, vim colorschemes). Themes are authored directly.

---

## Implementation language

zsh. The tool is for zsh users, ships zsh data files, and benefits from associative-array syntax. No Python or Bash dependency.

Single executable script `hue` with a shebang `#!/usr/bin/env zsh`.

---

## File layout (installed)

```
~/.local/bin/hue                        # the executable
~/.local/share/hue/themes/              # bundled themes (read-only, shipped with repo)
    solarized-light.zsh
    solarized-dark.zsh
    gruvbox-light.zsh
    gruvbox-dark.zsh
    nord.zsh
    tokyo-night.zsh
    tokyo-night-light.zsh
    catppuccin-latte.zsh
    catppuccin-mocha.zsh
    rose-pine.zsh
    rose-pine-dawn.zsh
    everforest-light.zsh
    everforest-dark.zsh
    kanagawa.zsh
    one-light.zsh
~/.config/hue/themes/                   # user themes (optional, override bundled)
```

## File layout (repo)

```
hue/
├── README.md
├── LICENSE
├── bin/
│   └── hue
├── themes/                             # installed to ~/.local/share/hue/themes
│   └── *.zsh
└── install.sh                          # optional, copies bin/ and themes/ into place
```

---

## CLI

```
hue <theme>                  Print the theme as eval-able zsh code on stdout.
hue generate <theme>         Alias of the above (vivid-compatible verb).
hue list                     List available theme names, one per line.
hue list --long              List with light/dark tag and one-line description.
hue path <theme>             Print the resolved file path for a theme.
hue current                  Print the most recently applied theme name (see state).
hue help                     Print usage.
hue version                  Print version.
```

Flags:

- `-q`, `--quiet` — suppress non-fatal warnings.
- `--no-user` — ignore `~/.config/hue/themes`, only use bundled.
- `--themes-dir <path>` — override search path entirely (also via `$HUE_THEMES_DIR`).

Exit codes: `0` success, `1` theme not found, `2` malformed theme, `64` usage error.

---

## Theme search order

1. `$HUE_THEMES_DIR` if set (colon-separated, like `$PATH`).
2. `~/.config/hue/themes`
3. `~/.local/share/hue/themes`
4. `/usr/local/share/hue/themes` (for system installs)

First match wins. `hue list` deduplicates by theme name across paths.

---

## Theme file format

Each theme is a zsh file. Required structure:

```zsh
# hue:name solarized-light
# hue:variant light
# hue:description Solarized Light, high contrast on parchment
# hue:author Ethan Schoonover (palette)

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       'fg=#586e75'
  unknown-token                 'fg=#dc322f,bold'
  # ... full key set
)
```

Header rules:

- Metadata lines are comments matching `^# hue:<key> <value>$`. Parsed by `hue list --long` and validation. Required keys: `name`, `variant` (one of `light`, `dark`). Optional: `description`, `author`.
- The body must be a single `typeset -gA ZSH_HIGHLIGHT_STYLES=(...)` declaration. Theme files are emitted to stdout verbatim by `hue <theme>`, so anything in the file ends up in the user's shell. Validation (below) enforces this.

### Required style keys

Every theme must define these keys (validated at theme-author time, not runtime):

```
default unknown-token reserved-word
command builtin alias function hashed-command precommand
path path_pathseparator globbing
single-quoted-argument double-quoted-argument
dollar-quoted-argument dollar-double-quoted-argument back-quoted-argument
single-hyphen-option double-hyphen-option
commandseparator redirection assign history-expansion
comment
bracket-error bracket-level-1 bracket-level-2 bracket-level-3 bracket-level-4
cursor-matchingbracket
```

Themes may set additional keys; unknown keys are passed through unchanged.

### Palette convention (recommended, not enforced)

A theme file may begin with `local` palette variables and reference them in the array, for readability:

```zsh
# hue:name solarized-light
# hue:variant light

local base03='#002b36' base02='#073642' base01='#586e75' base00='#657b83'
local yellow='#b58900' orange='#cb4b16' red='#dc322f' magenta='#d33682'
local violet='#6c71c4' blue='#268bd2' cyan='#2aa198' green='#859900'

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default      "fg=$base01"
  command      "fg=$blue,bold"
  # ...
)
```

This is fine because the theme is sourced via `eval` in the user's shell, where `local` works inside the eval'd block. Document the pattern in the README.

---

## Validation

`hue` performs minimal validation when emitting a theme:

1. File exists and is readable.
2. Header has `name` and `variant`.
3. File contains exactly one `typeset -gA ZSH_HIGHLIGHT_STYLES=(...)` declaration (regex check).
4. No obviously hostile content: reject any line containing `$(`, `` ` ``, or `eval ` outside of comments and the styles array. (Soft check; intent is to catch mistakes, not sandbox.)

On validation failure, exit 2 with a message naming the file and the rule that failed.

A separate `hue check <theme>` command runs validation explicitly (for theme authors) and additionally verifies all required keys are present.

`hue check --all` validates every theme in the search path.

---

## State (for `hue current`)

When `hue <theme>` succeeds, write the theme name to `${XDG_STATE_HOME:-$HOME/.local/state}/hue/current`. `hue current` reads this file. Used by helper functions in the README to re-apply the current theme after a change. Failures to write state are non-fatal warnings.

---

## Bundled themes (v1)

A balanced set, half light and half dark:

| Name | Variant | Source palette |
|---|---|---|
| solarized-light | light | Solarized |
| solarized-dark | dark | Solarized |
| gruvbox-light | light | Gruvbox |
| gruvbox-dark | dark | Gruvbox |
| tokyo-night | dark | Tokyo Night |
| tokyo-night-light | light | Tokyo Night Day |
| catppuccin-latte | light | Catppuccin |
| catppuccin-mocha | dark | Catppuccin |
| rose-pine | dark | Rosé Pine |
| rose-pine-dawn | light | Rosé Pine Dawn |
| everforest-light | light | Everforest |
| everforest-dark | dark | Everforest |
| nord | dark | Nord |
| kanagawa | dark | Kanagawa |
| one-light | light | Atom One Light |

All themes follow the same key set and contrast principles: no colour pairs that fail a basic legibility check against the intended background, and no reliance on green/red distinction alone (colorblind-friendly defaults).

---

## Testing

A `tests/` directory with a small zsh test runner. Required tests:

1. `hue list` includes every bundled theme exactly once.
2. `hue <name>` for every bundled theme produces output that, when eval'd in a fresh zsh, populates `ZSH_HIGHLIGHT_STYLES` with all required keys.
3. `hue nonexistent` exits 1 with a stderr message.
4. `hue check --all` passes on the shipped themes.
5. User theme in `~/.config/hue/themes` shadows bundled theme of the same name.

Run with `zsh tests/run.zsh`. No external test framework.

---

## README contents

The README must include, in order:

1. **What it does** — one paragraph and a screenshot or asciicast.
2. **Install** — see below.
3. **Use** — the three integration recipes (basic, runtime switch, auto light/dark).
4. **Themes** — the table above, with a note on how to preview (`eval "$(hue <name>)"; ls -la /tmp` or similar).
5. **Authoring themes** — the file format, palette convention, `hue check`.
6. **Contributing** — how to add a theme.

### Install section

```markdown
## Install

### Manual

    git clone https://github.com/USER/hue ~/src/hue
    install -m 0755 ~/src/hue/bin/hue ~/.local/bin/hue
    mkdir -p ~/.local/share/hue
    cp -r ~/src/hue/themes ~/.local/share/hue/

Make sure `~/.local/bin` is on your `$PATH`.

### Or run the installer

    cd ~/src/hue && ./install.sh
```

### Use section

This is the important part. Three recipes:

````markdown
## Use

### 1. Basic: pick a theme at shell startup

In your zshrc (before zsh-syntax-highlighting is sourced):

    eval "$(hue solarized-light)"
    source /path/to/zsh-syntax-highlighting.zsh

### 2. Switch themes at the prompt

Add this function to your zshrc:

    hue-set() {
      eval "$(hue ${1:?usage: hue-set <theme>})" || return
      # repaint current line so the new colours apply immediately
      zle && zle .reset-prompt
    }

Then `hue-set gruvbox-dark` works live.

### 3. Auto light/dark (macOS)

Add this to your zshrc:

    hue-auto() {
      local theme_light=${HUE_LIGHT:-solarized-light}
      local theme_dark=${HUE_DARK:-solarized-dark}
      local theme=$theme_light
      if [[ $OSTYPE == darwin* ]] \
         && defaults read -g AppleInterfaceStyle &>/dev/null; then
        theme=$theme_dark
      fi
      eval "$(hue $theme)"
      zle && zle .reset-prompt
    }
    hue-auto

Set `HUE_LIGHT` and `HUE_DARK` in your environment to override the defaults.
Re-run `hue-auto` after toggling system appearance, or wire it to a hook.

### 4. Linux equivalents

For GNOME:

    gsettings get org.gnome.desktop.interface color-scheme
    # 'prefer-dark' or 'default'

For KDE, check `$KDE_SESSION_VERSION` and `kreadconfig5`. The `hue-auto`
function is the integration point; adapt the detection block.
````

A short note on ordering matters: the eval has to run before the plugin is sourced, otherwise the plugin caches default styles and the override only takes effect on the next prompt redraw.

---

## Implementation notes for the agent

- Keep the script under ~250 lines. It is a router with file I/O, nothing more.
- Use `print -r --` for output, never `echo -e`.
- Use `${var:?msg}` for required arguments.
- Resolve `$HUE_THEMES_DIR` once at startup into a zsh array.
- `hue list --long` should parse headers without sourcing the file.
- The metadata regex: `^# hue:([a-z]+)[[:space:]]+(.+)$`.
- On `hue <theme>`, do not source the file; `cat` it after validation. The user's `eval` is what executes it. This keeps `hue` itself free of the theme's side effects.
- Ship the installer as a small `install.sh` that handles `~/.local/bin` and `~/.local/share/hue` and prints next steps. No Makefile.
- License: MIT.

---

## Out of scope (note for future versions)

- A `hue preview` subcommand that prints a sample command line with each style applied. Useful but adds rendering complexity; defer.
- Sharing palettes across other tools (bat, delta, fzf, eza). The right shape is a separate `palettes/` directory with named colour vars and per-tool generators. Not v1.
- Theme inheritance (`extends: solarized-light`). Not v1.
