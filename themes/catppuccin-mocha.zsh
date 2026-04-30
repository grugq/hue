# hue:name catppuccin-mocha
# hue:variant dark
# hue:description Catppuccin Mocha, soothing pastel night flavour
# hue:author Catppuccin (palette)

local text='#cdd6f4' subtext1='#bac2de' overlay1='#7f849c' overlay0='#6c7086'
local red='#f38ba8' maroon='#eba0ac' peach='#fab387' yellow='#f9e2af'
local green='#a6e3a1' teal='#94e2d5' sky='#89dceb' blue='#89b4fa'
local mauve='#cba6f7' pink='#f5c2e7'

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       "fg=$text"
  unknown-token                 "fg=$red,bold"
  reserved-word                 "fg=$mauve,bold"
  command                       "fg=$blue,bold"
  builtin                       "fg=$teal"
  alias                         "fg=$blue"
  function                      "fg=$blue,bold"
  hashed-command                "fg=$blue"
  precommand                    "fg=$teal,bold"
  path                          "fg=$text,underline"
  path_pathseparator            "fg=$overlay0"
  globbing                      "fg=$peach"
  single-quoted-argument        "fg=$green"
  double-quoted-argument        "fg=$green"
  dollar-quoted-argument        "fg=$green"
  dollar-double-quoted-argument "fg=$teal"
  back-quoted-argument          "fg=$teal"
  single-hyphen-option          "fg=$yellow"
  double-hyphen-option          "fg=$yellow"
  commandseparator              "fg=$mauve"
  redirection                   "fg=$peach"
  assign                        "fg=$sky"
  history-expansion             "fg=$pink,bold"
  comment                       "fg=$overlay1,italic"
  bracket-error                 "fg=$red,bold"
  bracket-level-1               "fg=$blue"
  bracket-level-2               "fg=$green"
  bracket-level-3               "fg=$mauve"
  bracket-level-4               "fg=$teal"
  cursor-matchingbracket        "standout"
)
