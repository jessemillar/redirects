#!/usr/bin/env bash

mkdir -p "$1" || true
sed "s,redirect-link,${2//&/\\&},g" template.html > "$1/index.html"
