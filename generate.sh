#!/usr/bin/env bash

dir="$1"
# Escape ampersand characters
link="${2//&/\\&}"
title="${3//&/\\&}"

mkdir -p "$dir" || true
sed "s,redirect-link,$link,g" template.html > "$dir/index.html"

if [ -z "$title" ]
then
	title="$(./title.sh "$dir" "$link")"
	sed "s,redirect-title,$title,g" "$dir/index.html" > "$dir/tmp.html"
fi

sed "s,redirect-title,$title,g" "$dir/index.html" > "$dir/tmp.html"

mv "$dir/tmp.html" "$dir/index.html"
