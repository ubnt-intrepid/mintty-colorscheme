#!/usr/bin/zsh

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
