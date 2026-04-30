#!/usr/bin/env sh
# Install hue into ~/.local. POSIX sh, no zsh required to run the installer.
set -eu

PREFIX=${PREFIX:-$HOME/.local}
BIN_DIR=$PREFIX/bin
SHARE_DIR=$PREFIX/share/hue

src_dir=$(cd "$(dirname "$0")" && pwd)

if [ ! -f "$src_dir/bin/hue" ]; then
  echo "install.sh: cannot find bin/hue next to this script" >&2
  exit 1
fi

mkdir -p "$BIN_DIR" "$SHARE_DIR/themes"
install -m 0755 "$src_dir/bin/hue" "$BIN_DIR/hue"

# Copy themes one at a time so we don't depend on cp -r flag variants.
for f in "$src_dir/themes"/*.zsh; do
  install -m 0644 "$f" "$SHARE_DIR/themes/"
done

cat <<EOF
Installed:
  $BIN_DIR/hue
  $SHARE_DIR/themes/  ($(ls "$SHARE_DIR/themes" | wc -l | tr -d ' ') themes)

Next steps:
  - Make sure $BIN_DIR is on your \$PATH.
  - In your zshrc, before sourcing zsh-syntax-highlighting, add:
        eval "\$(hue solarized-light)"
        source /path/to/zsh-syntax-highlighting.zsh
  - Run 'hue list' to see all available themes.
EOF
