#!/usr/bin/zsh

script_root="$(realpath $(dirname `realpath $0`))"
scheme_root=${scheme_root:-"$script_root"/schemes}

__color()       { echo -ne '\eP\e]'$1';'$2'\a' }
__colorscheme() { echo -ne '\eP\e]4;'$1';'$2'\a' }

ForegroundColour() { __color 10 "$*" }
BackgroundColour() { __color 11 "$*" }
CursorColour()     { __color 12 "$*" }

Black()       { __colorscheme 0 "$*" }
Red()         { __colorscheme 1 "$*" }
Green()       { __colorscheme 2 "$*" }
Yellow()      { __colorscheme 3 "$*" }
Blue()        { __colorscheme 4 "$*" }
Magenta()     { __colorscheme 5 "$*" }
Cyan()        { __colorscheme 6 "$*" }
White()       { __colorscheme 7 "$*" }
BoldBlack()   { __colorscheme 8 "$*" }
BoldRed()     { __colorscheme 9 "$*" }
BoldGreen()   { __colorscheme 10 "$*" }
BoldYellow()  { __colorscheme 11 "$*" }
BoldBlue()    { __colorscheme 12 "$*" }
BoldMagenta() { __colorscheme 13 "$*" }
BoldCyan()    { __colorscheme 14 "$*" }
BoldWhite()   { __colorscheme 15 "$*" }

__eval() {
  eval "${1%%=*} ${1##*=}"
  # echo $2
}

colorscheme_main() {

  function _usage { # {{{
    cat << EOF
A simple colorscheme management of mintty (for Cygwin/MSYS2)

Usage
    colorscheme [options] name

Options
    -l, --list     Show all colorschemes.
    -c=<cofigfile> Update values of colorscheme in the file.
EOF
  }
  # }}}
  
  local -A opthash
  zparseopts -D -M -A opthash -- \
    h  -help=h \
    l  -list=l \
    c: -config:=c \
    o  -overwrite=o

  if [[ -n "${opthash[(i)-h]}" ]]; then
    _usage "$0"
    return 0
  fi
  
  if [[ -n "${opthash[(i)-l]}" ]]; then
    basename -a "$scheme_root"/*(.)
    return 0
  fi

  local config=$HOME/.minttyrc
  if [[ -n "${opthash[(i)-c]}" ]]; then
    config="${opthash[-c]}"
    echo "config: $config"
  fi

  local overwrite=false
  if [[ -n "${opthash[(i)-o]}" ]]; then
    overwrite=true
    echo "overwrite: true"
  fi

  if (( $# != 1 )); then
    _usage "$0"
    return 1
  fi

  # read schemes
  local lines
  lines=( ${(@f)"$(< $scheme_root/$1)"} )
  lines=( ${lines:#\#*} )

  # eval lines
  local line
  for line in $lines; do
    __eval $line "$overwrite"
  done 
}

alias colorscheme="colorscheme_main"
