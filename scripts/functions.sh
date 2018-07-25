#!/usr/bin/env bash

function print_error {
  printf "\e[31m✘ ${1} \033\e[0m"
}

function print_ok {
  printf "\e[32m✔ ${1} \033\e[0m"
}
