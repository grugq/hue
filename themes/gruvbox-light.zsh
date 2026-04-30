# hue:name gruvbox-light
# hue:variant light
# hue:description Gruvbox Light, retro warm parchment
# hue:author Pavel Pertsev (palette)

local fg='#3c3836' fg2='#504945' gray='#7c6f64'
local red='#9d0006' green='#79740e' yellow='#b57614' blue='#076678'
local purple='#8f3f71' aqua='#427b58' orange='#af3a03'

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
  assign                        "fg=$yellow"
  history-expansion             "fg=$purple,bold"
  comment                       "fg=$gray,italic"
  bracket-error                 "fg=$red,bold"
  bracket-level-1               "fg=$blue"
  bracket-level-2               "fg=$aqua"
  bracket-level-3               "fg=$purple"
  bracket-level-4               "fg=$orange"
  cursor-matchingbracket        "standout"
)
