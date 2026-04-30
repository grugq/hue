# hue:name gruvbox-dark
# hue:variant dark
# hue:description Gruvbox Dark, retro warm earth tones
# hue:author Pavel Pertsev (palette)

local fg='#ebdbb2' fg2='#d5c4a1' gray='#928374'
local red='#fb4934' green='#b8bb26' yellow='#fabd2f' blue='#83a598'
local purple='#d3869b' aqua='#8ec07c' orange='#fe8019'

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
