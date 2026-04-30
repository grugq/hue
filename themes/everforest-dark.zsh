# hue:name everforest-dark
# hue:variant dark
# hue:description Everforest Dark, mossy comfort under canopy
# hue:author Sainnhe Park (palette)

local fg='#d3c6aa' fg_dim='#a7b29b' gray='#7a8478'
local red='#e67e80' orange='#e69875' yellow='#dbbc7f' green='#a7c080'
local aqua='#83c092' blue='#7fbbb3' purple='#d699b6'

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
