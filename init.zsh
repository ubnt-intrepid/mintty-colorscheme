#!/usr/bin/zsh

script_root="$(realpath $(dirname `realpath $0`))"

__color()       { echo -ne '\eP\e]'$1';'$2'\a' }
__colorscheme() { echo -ne '\eP\e]4;'$1';'$2'\a' }

ForegroundColour() { __color 10 $2 }
BackgroundColour() { __color 11 $2 }
CursorColour()     { __color 12 $2 }

Black()       { __colorscheme 0 $2 }
Red()         { __colorscheme 1 $2 }
Green()       { __colorscheme 2 $2 }
Yellow()      { __colorscheme 3 $2 }
Blue()        { __colorscheme 4 $2 }
Magenta()     { __colorscheme 5 $2 }
Cyan()        { __colorscheme 6 $2 }
White()       { __colorscheme 7 $2 }
BoldBlack()   { __colorscheme 8 $2 }
BoldRed()     { __colorscheme 9 $2 }
BoldGreen()   { __colorscheme 10 $2 }
BoldYellow()  { __colorscheme 11 $2 }
BoldBlue()    { __colorscheme 12 $2 }
BoldMagenta() { __colorscheme 13 $2 }
BoldCyan()    { __colorscheme 14 $2 }
BoldWhite()   { __colorscheme 15 $2 }

function __eval {
  eval "$@"
}

colorscheme_main() {

  if (( $# != 1 )); then
    echo "Usage:"
    echo "  colorscheme [--list]"
    echo "  colorscheme name"
    return 1
  fi

  if [[ "$1" == '--list' ]]; then
    local name
    for name in "${script_root}"/schemes/*(.); do
      echo -n "$(basename $name) "
    done
    echo
    return 0
  fi

  # read schemes
  lines=( ${(@f)"$(< $script_root/schemes/$1)"} )
  lines=( ${lines:#\#*} )

  # eval lines
  for line in $lines; do
    __eval $line
  done 
}

alias colorscheme="colorscheme_main"
