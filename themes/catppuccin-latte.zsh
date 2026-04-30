# hue:name catppuccin-latte
# hue:variant light
# hue:description Catppuccin Latte, warm pastel light flavour
# hue:author Catppuccin (palette)

local text='#4c4f69' subtext1='#5c5f77' overlay1='#8c8fa1' overlay0='#9ca0b0'
local red='#d20f39' maroon='#e64553' peach='#fe640b' yellow='#df8e1d'
local green='#40a02b' teal='#179299' sky='#04a5e5' blue='#1e66f5'
local mauve='#8839ef' pink='#ea76cb'

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
