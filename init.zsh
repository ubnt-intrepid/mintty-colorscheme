#!/usr/bin/zsh

function __colorscheme {
  local script_root="$(realpath $(dirname `realpath $0`))"

  if [[ "$#" -ne 1 ]]; then
    echo "Usage: colorscheme [--list] name"
    exit 1
  fi

  if [[ "$1" == '--list' ]]; then
    cd "${script_root}"/lib/colorschemes
    ls
    exit 0
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

  source "$script_root"/lib/colorschemes/"$1"
}

alias colorscheme=__colorscheme
