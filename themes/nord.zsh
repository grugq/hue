# hue:name nord
# hue:variant dark
# hue:description Nord, cool arctic palette
# hue:author Sven Greb / Arctic Ice Studio (palette)

local nord3='#4c566a' nord4='#d8dee9' nord5='#e5e9f0' nord6='#eceff4'
local frost1='#8fbcbb' frost2='#88c0d0' frost3='#81a1c1' frost4='#5e81ac'
local red='#bf616a' orange='#d08770' yellow='#ebcb8b' green='#a3be8c' purple='#b48ead'

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       "fg=$nord4"
  unknown-token                 "fg=$red,bold"
  reserved-word                 "fg=$purple,bold"
  command                       "fg=$frost2,bold"
  builtin                       "fg=$frost1"
  alias                         "fg=$frost2"
  function                      "fg=$frost3,bold"
  hashed-command                "fg=$frost2"
  precommand                    "fg=$frost1,bold"
  path                          "fg=$nord4,underline"
  path_pathseparator            "fg=$nord3"
  globbing                      "fg=$orange"
  single-quoted-argument        "fg=$green"
  double-quoted-argument        "fg=$green"
  dollar-quoted-argument        "fg=$green"
  dollar-double-quoted-argument "fg=$frost1"
  back-quoted-argument          "fg=$frost1"
  single-hyphen-option          "fg=$yellow"
  double-hyphen-option          "fg=$yellow"
  commandseparator              "fg=$purple"
  redirection                   "fg=$orange"
  assign                        "fg=$frost2"
  history-expansion             "fg=$purple,bold"
  comment                       "fg=$nord3,italic"
  bracket-error                 "fg=$red,bold"
  bracket-level-1               "fg=$frost3"
  bracket-level-2               "fg=$green"
  bracket-level-3               "fg=$purple"
  bracket-level-4               "fg=$frost1"
  cursor-matchingbracket        "standout"
)
