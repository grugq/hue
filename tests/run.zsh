#!/usr/bin/env zsh
# Minimal test runner for hue. Run with: zsh tests/run.zsh

emulate -L zsh
setopt extended_glob

local repo_root=${0:A:h:h}
local hue=$repo_root/bin/hue
local themes_dir=$repo_root/themes

if [[ ! -x $hue ]]; then
  print -r -- "tests: cannot find executable hue at $hue" >&2
  exit 2
fi

# Sandbox state and config in a tmpdir so we don't pollute the user.
local tmp
tmp=$(mktemp -d -t hue-tests.XXXXXX)
trap 'rm -rf $tmp' EXIT INT TERM

export XDG_STATE_HOME=$tmp/state
export HUE_THEMES_DIR=$themes_dir

typeset -gi PASS=0 FAIL=0
typeset -ga FAILURES=()

ok() {
  print -r -- "  ok   $1"
  : $(( PASS = PASS + 1 ))
}

fail() {
  print -r -- "  FAIL $1"
  FAILURES+=( "$1" )
  : $(( FAIL = FAIL + 1 ))
}

run_test() {
  local name=$1
  shift
  print -r -- "test: $name"
  if "$@"; then
    :
  else
    fail "$name returned non-zero"
  fi
}

# The required key set, kept in sync with bin/hue.
typeset -ga REQUIRED_KEYS=(
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
)

# The expected bundled theme names from the spec.
typeset -ga EXPECTED_THEMES=(
  solarized-light solarized-dark
  gruvbox-light gruvbox-dark
  tokyo-night tokyo-night-light
  catppuccin-latte catppuccin-mocha
  rose-pine rose-pine-dawn
  everforest-light everforest-dark
  nord kanagawa one-light
)

#############################################################################

test_list_contains_all_bundled_themes() {
  local out
  out=$($hue list) || { fail "hue list exited non-zero"; return 1 }
  local theme
  for theme in $EXPECTED_THEMES; do
    local count=$(print -r -- "$out" | grep -cE "^${theme}\$")
    if (( count == 1 )); then
      ok "list contains $theme exactly once"
    else
      fail "list contains $theme ($count times)"
    fi
  done
}

test_eval_each_theme_in_fresh_zsh() {
  local probe=$tmp/probe.zsh
  # Emit a probe that loads the theme then dumps any missing keys.
  cat > $probe <<PROBE
emulate -L zsh
source \$1
typeset -ga REQUIRED_KEYS=( ${REQUIRED_KEYS[@]} )
local key
for key in \$REQUIRED_KEYS; do
  if [[ -z \${ZSH_HIGHLIGHT_STYLES[\$key]:-} ]]; then
    print -r -- "MISSING:\$key"
  fi
done
print -r -- "KEYS:\${#ZSH_HIGHLIGHT_STYLES[@]}"
PROBE

  local theme theme_file result
  for theme in $EXPECTED_THEMES; do
    theme_file=$tmp/$theme.zsh
    if ! $hue $theme > $theme_file 2>/dev/null; then
      fail "hue $theme exited non-zero"
      continue
    fi
    result=$(zsh --no-rcs $probe $theme_file 2>&1) || {
      fail "eval failed for $theme: $result"
      continue
    }
    if [[ $result == *MISSING:* ]]; then
      fail "$theme missing keys: ${result%%KEYS:*}"
    else
      ok "$theme evals with all required keys"
    fi
  done
}

test_nonexistent_theme_exits_1() {
  local stderr
  stderr=$($hue does-not-exist 2>&1 >/dev/null)
  local rc=$?
  if (( rc == 1 )) && [[ -n $stderr ]]; then
    ok "missing theme exits 1 with stderr message"
  else
    fail "missing theme: exit=$rc stderr=$stderr"
  fi
}

test_check_all_passes_on_bundled() {
  if $hue check --all >/dev/null; then
    ok "check --all passes on bundled themes"
  else
    fail "check --all failed on bundled themes"
  fi
}

test_user_theme_shadows_bundled() {
  # Create a fake user dir with a theme named 'solarized-light' but with a
  # tell-tale color. Confirm the user dir wins via search-path priority.
  local user_dir=$tmp/user-themes
  mkdir -p $user_dir
  cat > $user_dir/solarized-light.zsh <<'THEME'
# hue:name solarized-light
# hue:variant light
# hue:description shadow test theme

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       'fg=#abcdef'
  unknown-token                 'fg=#abcdef,bold'
  reserved-word                 'fg=#abcdef'
  command                       'fg=#abcdef,bold'
  builtin                       'fg=#abcdef'
  alias                         'fg=#abcdef'
  function                      'fg=#abcdef'
  hashed-command                'fg=#abcdef'
  precommand                    'fg=#abcdef'
  path                          'fg=#abcdef'
  path_pathseparator            'fg=#abcdef'
  globbing                      'fg=#abcdef'
  single-quoted-argument        'fg=#abcdef'
  double-quoted-argument        'fg=#abcdef'
  dollar-quoted-argument        'fg=#abcdef'
  dollar-double-quoted-argument 'fg=#abcdef'
  back-quoted-argument          'fg=#abcdef'
  single-hyphen-option          'fg=#abcdef'
  double-hyphen-option          'fg=#abcdef'
  commandseparator              'fg=#abcdef'
  redirection                   'fg=#abcdef'
  assign                        'fg=#abcdef'
  history-expansion             'fg=#abcdef'
  comment                       'fg=#abcdef'
  bracket-error                 'fg=#abcdef'
  bracket-level-1               'fg=#abcdef'
  bracket-level-2               'fg=#abcdef'
  bracket-level-3               'fg=#abcdef'
  bracket-level-4               'fg=#abcdef'
  cursor-matchingbracket        'standout'
)
THEME

  # User dir first, repo themes second — user must win.
  local out
  out=$(HUE_THEMES_DIR=$user_dir:$themes_dir $hue solarized-light)
  if [[ $out == *'#abcdef'* ]]; then
    ok "user theme shadows bundled theme"
  else
    fail "user theme did not shadow: $out"
  fi
}

test_state_records_current_theme() {
  rm -f $XDG_STATE_HOME/hue/current
  $hue solarized-dark >/dev/null
  local current
  current=$($hue current 2>/dev/null) || { fail "hue current failed after emit"; return 1 }
  if [[ $current == solarized-dark ]]; then
    ok "state file records last applied theme"
  else
    fail "state file records '$current', expected 'solarized-dark'"
  fi
}

test_check_rejects_malformed_theme() {
  local bad_dir=$tmp/bad-themes
  mkdir -p $bad_dir
  # No header, no typeset declaration.
  cat > $bad_dir/broken.zsh <<'THEME'
# this file is not a valid theme
print "hello"
THEME
  local rc=0
  HUE_THEMES_DIR=$bad_dir $hue check broken 2>/dev/null || rc=$?
  if (( rc == 2 )); then
    ok "check rejects malformed theme with exit 2"
  else
    fail "check on malformed theme exited $rc, expected 2"
  fi
}

test_path_resolves_theme_file() {
  local out
  out=$($hue path nord)
  if [[ $out == */themes/nord.zsh ]]; then
    ok "path resolves to bundled file"
  else
    fail "path returned '$out'"
  fi
}

#############################################################################

run_test "list contains every bundled theme exactly once" test_list_contains_all_bundled_themes
run_test "every bundled theme evals all required keys"    test_eval_each_theme_in_fresh_zsh
run_test "missing theme exits 1 with a stderr message"     test_nonexistent_theme_exits_1
run_test "check --all passes on shipped themes"            test_check_all_passes_on_bundled
run_test "user theme shadows bundled"                       test_user_theme_shadows_bundled
run_test "state records the last applied theme"             test_state_records_current_theme
run_test "check rejects malformed theme"                    test_check_rejects_malformed_theme
run_test "path subcommand resolves a theme file"            test_path_resolves_theme_file

print
print -r -- "passed: $PASS   failed: $FAIL"
if (( FAIL > 0 )); then
  print -r -- "failures:"
  for f in $FAILURES; do
    print -r -- "  - $f"
  done
  exit 1
fi
exit 0
