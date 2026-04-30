# hue

A theme manager for [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting). Pick a curated colour scheme — Solarized, Gruvbox, Tokyo Night, Catppuccin, Rosé Pine, Everforest, Nord, Kanagawa, Atom One Light — in light or dark variants, switch at the prompt, and adapt automatically to the system appearance.

Modeled on [`vivid`](https://github.com/sharkdp/vivid), which does the same job for `LS_COLORS`. The shape of the integration is identical:

    eval "$(hue solarized-light)"
    source /path/to/zsh-syntax-highlighting.zsh

Themes are data files (zsh associative-array literals), not code. Adding a theme is dropping a file into a directory.

---

## Install

### Manual

    git clone https://github.com/grugq/hue ~/src/hue
    install -m 0755 ~/src/hue/bin/hue ~/.local/bin/hue
    mkdir -p ~/.local/share/hue
    cp -r ~/src/hue/themes ~/.local/share/hue/
    install -m 0644 ~/src/hue/completions/_hue ~/.local/share/zsh/site-functions/_hue

Make sure `~/.local/bin` is on your `$PATH`. To enable tab completion, add the completion directory to `$fpath` **before** `compinit` runs:

    fpath=(~/.local/share/zsh/site-functions $fpath)
    autoload -U compinit && compinit

### Or run the installer

    cd ~/src/hue && ./install.sh

`PREFIX=/usr/local sudo ./install.sh` for a system-wide install.

---

## Use

The eval has to run **before** `zsh-syntax-highlighting` is sourced — otherwise the plugin caches its default styles and your override only takes effect on the next prompt redraw.

### 1. Basic: pick a theme at shell startup

In your `~/.zshrc`:

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

Set `HUE_LIGHT` and `HUE_DARK` in your environment to override the defaults. Re-run `hue-auto` after toggling system appearance, or wire it to a hook.

### 4. Linux equivalents

For GNOME, swap the macOS detection block for:

    if [[ $(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null) == *prefer-dark* ]]; then
      theme=$theme_dark
    fi

For KDE, check `$KDE_SESSION_VERSION` and `kreadconfig5 --group "General" --key "ColorScheme"`. The `hue-auto` function is the integration point; adapt the detection block.

---

## Themes

| Name                | Variant | Source palette       |
|---------------------|---------|----------------------|
| solarized-light     | light   | Solarized            |
| solarized-dark      | dark    | Solarized            |
| gruvbox-light       | light   | Gruvbox              |
| gruvbox-dark        | dark    | Gruvbox              |
| tokyo-night         | dark    | Tokyo Night Storm    |
| tokyo-night-light   | light   | Tokyo Night Day      |
| catppuccin-latte    | light   | Catppuccin           |
| catppuccin-mocha    | dark    | Catppuccin           |
| rose-pine           | dark    | Rosé Pine            |
| rose-pine-dawn      | light   | Rosé Pine Dawn       |
| everforest-light    | light   | Everforest           |
| everforest-dark     | dark    | Everforest           |
| nord                | dark    | Nord                 |
| kanagawa            | dark    | Kanagawa Wave        |
| one-light           | light   | Atom One Light       |

`hue list` prints names; `hue list --long` adds variant and description.

To preview a theme without changing your zshrc, paste this in a terminal that already has `zsh-syntax-highlighting` loaded:

    eval "$(hue catppuccin-mocha)"
    # then type any sample command to see the new colours
    ls -la /tmp ~/.config 2>/dev/null | head

---

## Authoring themes

A theme is a single zsh file. The required shape:

    # hue:name solarized-light
    # hue:variant light
    # hue:description Solarized Light, low-contrast parchment
    # hue:author Ethan Schoonover (palette)

    local base01='#586e75' base00='#657b83' base1='#93a1a1'
    local yellow='#b58900' red='#dc322f' magenta='#d33682'
    local violet='#6c71c4' blue='#268bd2' cyan='#2aa198' green='#859900'

    typeset -gA ZSH_HIGHLIGHT_STYLES=(
      default                       "fg=$base00"
      unknown-token                 "fg=$red,bold"
      # ... full key set
    )

Header rules:

- Each metadata line matches `# hue:<key> <value>`. `name` and `variant` (`light` or `dark`) are required; `description` and `author` are optional.
- The body must be a single `typeset -gA ZSH_HIGHLIGHT_STYLES=(...)` declaration.
- Theme files are emitted to stdout verbatim by `hue <theme>`, so anything in the file ends up in the user's shell. The validator rejects `$(...)`, backticks, and `eval ` outside comments and the styles array.

The palette `local` convention is recommended (it makes themes much easier to read and re-tune). It works because `eval` runs in the user's shell, where `local` declarations and variable expansion both apply to the array values.

### Required style keys

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

Run `hue check <theme>` to validate header + key set, or `hue check --all` to validate every theme on the search path.

### User themes

Drop a theme file into `~/.config/hue/themes/`. It will shadow a bundled theme of the same name.

Override the search path entirely with `--themes-dir` or `$HUE_THEMES_DIR` (colon-separated, like `$PATH`).

---

## CLI

    hue <theme>                  Print the theme as eval-able zsh code.
    hue generate <theme>         Alias of the above (vivid-compatible verb).
    hue list [--long]            List available theme names.
    hue path <theme>             Print the resolved file path for a theme.
    hue current                  Print the most recently applied theme name.
    hue check <theme>|--all      Validate theme(s).
    hue help                     Print usage.
    hue version                  Print version.

Flags: `-q`/`--quiet` (suppress non-fatal warnings), `--no-user` (ignore `~/.config/hue/themes`), `--themes-dir <path>`.

Search order: `$HUE_THEMES_DIR` if set, then `~/.config/hue/themes`, `~/.local/share/hue/themes`, `/usr/local/share/hue/themes`. First match wins.

`hue current` reads `$XDG_STATE_HOME/hue/current` (falling back to `~/.local/state/hue/current`); the file is written every time `hue <theme>` succeeds.

Exit codes: `0` ok, `1` theme not found, `2` malformed theme, `64` usage error.

---

## Tests

    zsh tests/run.zsh

No external test framework; the runner is a single zsh file.

---

## Contributing

To add a theme:

1. Drop `themes/your-theme.zsh` into the repo, following the template above.
2. Run `zsh tests/run.zsh` and add your theme name to `EXPECTED_THEMES` in `tests/run.zsh`.
3. Update the table in this README.

Themes that fail a basic legibility check (low-contrast on the intended background) or rely on red/green distinction alone will be rejected — most of `zsh-syntax-highlighting`'s users care a lot about both.

## License

MIT — see [LICENSE](LICENSE).
