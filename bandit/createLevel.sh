#!/bin/bash

level_number=$1
if [[ $# -eq 0 || $level_number -le 0 || $level_number -ge 35 ]]; then
  echo "Please input a valid level number 1-34"
  exit 1
fi

new_level_file="level$level_number.md"
if [[ -e $new_level_file ]]; then
  echo "Level $level_number already exists!"
  exit 1
fi

cp level.md $new_level_file
sed -i "s/Level 00/Level $level_number/g" $new_level_file
