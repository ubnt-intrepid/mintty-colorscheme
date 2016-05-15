#!/usr/bin/zsh

script_root="$(realpath $(dirname `realpath $0`))"

colorscheme_main() {

  if [[ "$#" -ne 1 ]]; then
    echo "Usage: colorscheme [--list] name"
    return 1
  fi

  if [[ "$1" == '--list' ]]; then
    ls "${script_root}"/schemes
    return 0
  fi

  function __color {
    echo -ne '\eP\e]'$1';#'$2'\a'
  }

  function __colorscheme {
    echo -ne '\eP\e]4;'$1';#'$2'\a'
  }

  function __eval_line {
    local name=$1

    # read schemes
    local lines=( ${(@f)"$(< $script_root/schemes/$name)"} )
    lines=( ${lines:#\#*} )

    # eval lines
    local line
    for line in $lines; do
      eval "$line"
    done 
  }

  __eval_line $1
}

alias colorscheme="colorscheme_main"
