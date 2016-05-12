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
    local id=$1
    local color=$2
    echo -ne '\eP\e]'$id';#'$color'\a'
  }

  function __colorscheme {
    local id=$1
    local color=$2
    echo -ne '\eP\e]4;'$id';#'$color'\a'
  }

  source "$script_root"/schemes/"$1"
}

alias colorscheme="colorscheme_main"
