# hue:name tokyo-night-light
# hue:variant light
# hue:description Tokyo Night Day, twilight palette inverted for daylight
# hue:author Enkia (palette)

local fg='#3760bf' comment='#848cb5' fg_dim='#9699a3'
local red='#f52a65' orange='#b15c00' yellow='#8c6c3e' green='#587539'
local teal='#118c74' cyan='#007197' blue='#2e7de9' purple='#9854f1'

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       "fg=$fg"
  unknown-token                 "fg=$red,bold"
  reserved-word                 "fg=$purple,bold"
  command                       "fg=$blue,bold"
  builtin                       "fg=$cyan"
  alias                         "fg=$blue"
  function                      "fg=$blue,bold"
  hashed-command                "fg=$blue"
  precommand                    "fg=$teal,bold"
  path                          "fg=$fg,underline"
  path_pathseparator            "fg=$fg_dim"
  globbing                      "fg=$orange"
  single-quoted-argument        "fg=$green"
  double-quoted-argument        "fg=$green"
  dollar-quoted-argument        "fg=$green"
  dollar-double-quoted-argument "fg=$teal"
  back-quoted-argument          "fg=$teal"
  single-hyphen-option          "fg=$yellow"
  double-hyphen-option          "fg=$yellow"
  commandseparator              "fg=$purple"
  redirection                   "fg=$orange"
  assign                        "fg=$cyan"
  history-expansion             "fg=$purple,bold"
  comment                       "fg=$comment,italic"
  bracket-error                 "fg=$red,bold"
  bracket-level-1               "fg=$blue"
  bracket-level-2               "fg=$green"
  bracket-level-3               "fg=$purple"
  bracket-level-4               "fg=$cyan"
  cursor-matchingbracket        "standout"
)
