#!/usr/bin/env bash

./generate.sh "$1" "$2"
git add -A
git commit -m "Automatic creation of the \"$1\" redirect for \"$2\""
git push
