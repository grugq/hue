# hue:name kanagawa
# hue:variant dark
# hue:description Kanagawa Wave, ink-on-paper after Hokusai
# hue:author rebelot (palette)

local fg='#dcd7ba' comment='#727169' fg_dim='#a6a69c'
local red='#c34043' yellow='#c0a36e' orange='#ffa066'
local green='#76946a' blue='#7e9cd8' light_blue='#7fb4ca'
local purple='#957fb8' aqua='#7aa89f' pink='#d27e99'

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       "fg=$fg"
  unknown-token                 "fg=$red,bold"
  reserved-word                 "fg=$purple,bold"
  command                       "fg=$blue,bold"
  builtin                       "fg=$aqua"
  alias                         "fg=$blue"
  function                      "fg=$light_blue,bold"
  hashed-command                "fg=$blue"
  precommand                    "fg=$aqua,bold"
  path                          "fg=$fg,underline"
  path_pathseparator            "fg=$comment"
  globbing                      "fg=$orange"
  single-quoted-argument        "fg=$yellow"
  double-quoted-argument        "fg=$yellow"
  dollar-quoted-argument        "fg=$yellow"
  dollar-double-quoted-argument "fg=$aqua"
  back-quoted-argument          "fg=$aqua"
  single-hyphen-option          "fg=$orange"
  double-hyphen-option          "fg=$orange"
  commandseparator              "fg=$pink"
  redirection                   "fg=$pink"
  assign                        "fg=$light_blue"
  history-expansion             "fg=$purple,bold"
  comment                       "fg=$comment,italic"
  bracket-error                 "fg=$red,bold"
  bracket-level-1               "fg=$blue"
  bracket-level-2               "fg=$green"
  bracket-level-3               "fg=$purple"
  bracket-level-4               "fg=$aqua"
  cursor-matchingbracket        "standout"
)
