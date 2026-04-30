# hue:name rose-pine-dawn
# hue:variant light
# hue:description Rosé Pine Dawn, soho vibes for the daydreaming
# hue:author Rosé Pine (palette)

local text='#575279' subtle='#797593' muted='#9893a5'
local love='#b4637a' gold='#ea9d34' rose='#d7827e'
local pine='#286983' foam='#56949f' iris='#907aa9'

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  default                       "fg=$text"
  unknown-token                 "fg=$love,bold"
  reserved-word                 "fg=$iris,bold"
  command                       "fg=$foam,bold"
  builtin                       "fg=$foam"
  alias                         "fg=$foam"
  function                      "fg=$rose,bold"
  hashed-command                "fg=$foam"
  precommand                    "fg=$pine,bold"
  path                          "fg=$text,underline"
  path_pathseparator            "fg=$muted"
  globbing                      "fg=$gold"
  single-quoted-argument        "fg=$gold"
  double-quoted-argument        "fg=$gold"
  dollar-quoted-argument        "fg=$gold"
  dollar-double-quoted-argument "fg=$rose"
  back-quoted-argument          "fg=$rose"
  single-hyphen-option          "fg=$rose"
  double-hyphen-option          "fg=$rose"
  commandseparator              "fg=$iris"
  redirection                   "fg=$love"
  assign                        "fg=$foam"
  history-expansion             "fg=$iris,bold"
  comment                       "fg=$muted,italic"
  bracket-error                 "fg=$love,bold"
  bracket-level-1               "fg=$foam"
  bracket-level-2               "fg=$rose"
  bracket-level-3               "fg=$iris"
  bracket-level-4               "fg=$gold"
  cursor-matchingbracket        "standout"
)
