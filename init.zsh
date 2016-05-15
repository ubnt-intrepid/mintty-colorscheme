#!/usr/bin/zsh

script_root="$(realpath $(dirname `realpath $0`))"

colorscheme_main() {

  if [[ "$#" -ne 1 ]]; then
    echo "Usage: colorscheme [--list] name"
    return 1
  fi

  if [[ "$1" == '--list' ]]; then
    for name in "${script_root}"/schemes/*(.); do
      basename $name
    done
    return 0
  fi

  function __eval {
    __color()       { echo -ne '\eP\e]'$1';#'$2'\a' }
    __colorscheme() { echo -ne '\eP\e]4;'$1';#'$2'\a' }
    eval "$@"
  }

  # read schemes
  lines=( ${(@f)"$(< $script_root/schemes/$1)"} )
  lines=( ${lines:#\#*} )

  # eval lines
  for line in $lines; do
    __eval $line
  done 
}

alias colorscheme="colorscheme_main"
