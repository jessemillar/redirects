#!/usr/bin/env bash

dir="$1"
# Escape ampersand characters
link="${2//&/\\&}"
title="${3//&/\\&}"

mkdir -p "$dir" || true
sed "s,redirect-link,$link,g" template.html > "$dir/index.html"

if [ -z "$title" ]
then
	# Use the link as the page title
	sed "s,redirect-title,Redirecting to $link,g" "$dir/index.html" > "$dir/tmp.html"
else
	# Use the supplied page title
	sed "s,redirect-title,$title,g" "$dir/index.html" > "$dir/tmp.html"
fi

mv "$dir/tmp.html" "$dir/index.html"
