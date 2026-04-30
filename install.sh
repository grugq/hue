#!/usr/bin/env sh
# Install hue into ~/.local. POSIX sh, no zsh required to run the installer.
set -eu

PREFIX=${PREFIX:-$HOME/.local}
BIN_DIR=$PREFIX/bin
SHARE_DIR=$PREFIX/share/hue
COMP_DIR=$PREFIX/share/zsh/site-functions

src_dir=$(cd "$(dirname "$0")" && pwd)

if [ ! -f "$src_dir/bin/hue" ]; then
  echo "install.sh: cannot find bin/hue next to this script" >&2
  exit 1
fi

mkdir -p "$BIN_DIR" "$SHARE_DIR/themes" "$COMP_DIR"
install -m 0755 "$src_dir/bin/hue" "$BIN_DIR/hue"
install -m 0644 "$src_dir/completions/_hue" "$COMP_DIR/_hue"

# Copy themes one at a time so we don't depend on cp -r flag variants.
for f in "$src_dir/themes"/*.zsh; do
  install -m 0644 "$f" "$SHARE_DIR/themes/"
done

cat <<EOF
Installed:
  $BIN_DIR/hue
  $SHARE_DIR/themes/  ($(ls "$SHARE_DIR/themes" | wc -l | tr -d ' ') themes)
  $COMP_DIR/_hue

Next steps:
  - Make sure $BIN_DIR is on your \$PATH.
  - To enable tab completion, ensure $COMP_DIR is on your \$fpath
    before compinit runs. In your zshrc, before 'autoload -U compinit; compinit':
        fpath=($COMP_DIR \$fpath)
  - In your zshrc, before sourcing zsh-syntax-highlighting, add:
        eval "\$(hue solarized-light)"
        source /path/to/zsh-syntax-highlighting.zsh
  - Run 'hue list' to see all available themes.
EOF
