#!/usr/bin/zsh

script_root="$(realpath $(dirname `realpath $0`))"

__color()       { echo -ne '\eP\e]'$1';'$2'\a' }
__colorscheme() { echo -ne '\eP\e]4;'$1';'$2'\a' }

ForegroundColour() { __color 10 "$@" }
BackgroundColour() { __color 11 "$@" }
CursorColour()     { __color 12 "$@" }

Black()       { __colorscheme 0 "$@" }
Red()         { __colorscheme 1 "$@" }
Green()       { __colorscheme 2 "$@" }
Yellow()      { __colorscheme 3 "$@" }
Blue()        { __colorscheme 4 "$@" }
Magenta()     { __colorscheme 5 "$@" }
Cyan()        { __colorscheme 6 "$@" }
White()       { __colorscheme 7 "$@" }
BoldBlack()   { __colorscheme 8 "$@" }
BoldRed()     { __colorscheme 9 "$@" }
BoldGreen()   { __colorscheme 10 "$@" }
BoldYellow()  { __colorscheme 11 "$@" }
BoldBlue()    { __colorscheme 12 "$@" }
BoldMagenta() { __colorscheme 13 "$@" }
BoldCyan()    { __colorscheme 14 "$@" }
BoldWhite()   { __colorscheme 15 "$@" }

__eval() {
  eval "${@%%=*} ${@##*=}"
}

colorscheme_main() {

  if (( $# != 1 )); then
    echo "Usage:"
    echo "  colorscheme [--list]"
    echo "  colorscheme name"
    return 1
  fi

  if [[ "$1" == '--list' ]]; then
    basename -a "${script_root}"/schemes/*(.)
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
