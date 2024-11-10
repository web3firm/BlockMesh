#!/bin/bash
tput civis

# Clear line
CL="\e[2K"
# Spinner characters
SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"

function spinner() {
  task=$1
  msg=$2
  while :; do
    jobs %1 > /dev/null 2>&1
    [ $? = 0 ] || {
      printf "${CL}✓ ${task} completed\n"
      break
    }
    for (( i=0; i<${#SPINNER}; i++ )); do
      sleep 0.05
      printf "${CL}${SPINNER:$i:1} ${task} ${msg}\r"
    done
  done
}

msg="${2-in progress}"
task="${3-$1}"
$1 & spinner "$task" "$msg"

tput cnorm

# Example usage => ./loader.sh "<sleep duration>" "<progress>" "<task name>"
# For example => ./loader.sh "sleep 5" "..." "Installing dependencies"