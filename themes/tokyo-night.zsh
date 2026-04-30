# hue:name tokyo-night
# hue:variant dark
# hue:description Tokyo Night Storm, twilight neon over dusk
# hue:author Enkia (palette)

local fg='#a9b1d6' comment='#565f89' fg_dim='#787c99'
local red='#f7768e' orange='#ff9e64' yellow='#e0af68' green='#9ece6a'
local teal='#73daca' cyan='#7dcfff' blue='#7aa2f7' purple='#bb9af7'

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
