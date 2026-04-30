# hue:name solarized-light
# hue:variant light
# hue:description Solarized Light, low-contrast parchment
# hue:author Ethan Schoonover (palette)

local base01='#586e75' base00='#657b83' base0='#839496' base1='#93a1a1'
local yellow='#b58900' orange='#cb4b16' red='#dc322f' magenta='#d33682'
local violet='#6c71c4' blue='#268bd2' cyan='#2aa198' green='#859900'

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       "fg=$base00"
  unknown-token                 "fg=$red,bold"
  reserved-word                 "fg=$violet,bold"
  command                       "fg=$blue,bold"
  builtin                       "fg=$blue"
  alias                         "fg=$blue"
  function                      "fg=$blue,bold"
  hashed-command                "fg=$blue"
  precommand                    "fg=$cyan,bold"
  path                          "fg=$base00,underline"
  path_pathseparator            "fg=$base1"
  globbing                      "fg=$orange"
  single-quoted-argument        "fg=$yellow"
  double-quoted-argument        "fg=$yellow"
  dollar-quoted-argument        "fg=$yellow"
  dollar-double-quoted-argument "fg=$cyan"
  back-quoted-argument          "fg=$cyan"
  single-hyphen-option          "fg=$cyan"
  double-hyphen-option          "fg=$cyan"
  commandseparator              "fg=$magenta"
  redirection                   "fg=$magenta"
  assign                        "fg=$yellow"
  history-expansion             "fg=$magenta,bold"
  comment                       "fg=$base1"
  bracket-error                 "fg=$red,bold"
  bracket-level-1               "fg=$blue"
  bracket-level-2               "fg=$green"
  bracket-level-3               "fg=$magenta"
  bracket-level-4               "fg=$cyan"
  cursor-matchingbracket        "standout"
)
