# hue:name one-light
# hue:variant light
# hue:description Atom One Light, clean editor classic
# hue:author Atom (palette)

local fg='#383a42' comment='#a0a1a7' fg_dim='#696c77'
local red='#e45649' deep_red='#ca1243' orange='#986801' yellow='#c18401'
local green='#50a14f' blue='#4078f2' purple='#a626a4' cyan='#0184bc'

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       "fg=$fg"
  unknown-token                 "fg=$deep_red,bold"
  reserved-word                 "fg=$purple,bold"
  command                       "fg=$blue,bold"
  builtin                       "fg=$cyan"
  alias                         "fg=$blue"
  function                      "fg=$blue,bold"
  hashed-command                "fg=$blue"
  precommand                    "fg=$cyan,bold"
  path                          "fg=$fg,underline"
  path_pathseparator            "fg=$comment"
  globbing                      "fg=$orange"
  single-quoted-argument        "fg=$green"
  double-quoted-argument        "fg=$green"
  dollar-quoted-argument        "fg=$green"
  dollar-double-quoted-argument "fg=$cyan"
  back-quoted-argument          "fg=$cyan"
  single-hyphen-option          "fg=$yellow"
  double-hyphen-option          "fg=$yellow"
  commandseparator              "fg=$purple"
  redirection                   "fg=$red"
  assign                        "fg=$cyan"
  history-expansion             "fg=$purple,bold"
  comment                       "fg=$comment,italic"
  bracket-error                 "fg=$deep_red,bold"
  bracket-level-1               "fg=$blue"
  bracket-level-2               "fg=$green"
  bracket-level-3               "fg=$purple"
  bracket-level-4               "fg=$cyan"
  cursor-matchingbracket        "standout"
)
