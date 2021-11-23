#!/bin/zsh -l
DIR=${${(%):-%x}:A:h} # https://stackoverflow.com/a/23259585
cd "$DIR" || exit 1
overmind start