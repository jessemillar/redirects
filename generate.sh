#!/usr/bin/env bash

mkdir -p "$1" || true
sed "s,redirect-link,$2,g" template.html > "$1/index.html"
git add -A
git commit -m "Automatic creation of the \"$1\" redirect for \"$2\""
git push
