# hue:name everforest-light
# hue:variant light
# hue:description Everforest Light, gentle forest in daylight
# hue:author Sainnhe Park (palette)

local fg='#5c6a72' fg_dim='#829181' gray='#939f91'
local red='#f85552' orange='#f57d26' yellow='#dfa000' green='#8da101'
local aqua='#35a77c' blue='#3a94c5' purple='#df69ba'

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       "fg=$fg"
  unknown-token                 "fg=$red,bold"
  reserved-word                 "fg=$purple,bold"
  command                       "fg=$green,bold"
  builtin                       "fg=$aqua"
  alias                         "fg=$green"
  function                      "fg=$blue,bold"
  hashed-command                "fg=$green"
  precommand                    "fg=$aqua,bold"
  path                          "fg=$fg,underline"
  path_pathseparator            "fg=$gray"
  globbing                      "fg=$orange"
  single-quoted-argument        "fg=$yellow"
  double-quoted-argument        "fg=$yellow"
  dollar-quoted-argument        "fg=$yellow"
  dollar-double-quoted-argument "fg=$aqua"
  back-quoted-argument          "fg=$aqua"
  single-hyphen-option          "fg=$orange"
  double-hyphen-option          "fg=$orange"
  commandseparator              "fg=$purple"
  redirection                   "fg=$purple"
  assign                        "fg=$blue"
  history-expansion             "fg=$purple,bold"
  comment                       "fg=$gray,italic"
  bracket-error                 "fg=$red,bold"
  bracket-level-1               "fg=$blue"
  bracket-level-2               "fg=$aqua"
  bracket-level-3               "fg=$purple"
  bracket-level-4               "fg=$orange"
  cursor-matchingbracket        "standout"
)
