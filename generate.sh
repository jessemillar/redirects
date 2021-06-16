#!/usr/bin/env bash

mkdir -p "$1" || true
sed "s,redirect-link,${2//&/\\&},g" template.html > "$1/index.html"

if [ -z "$3" ]
then
	# Use the link as the page title
	sed "s,redirect-title,Redirecting to ${2//&/\\&},g" "$1/index.html" > "$1/tmp.html"
else
	# Use the supplied page title
	sed "s,redirect-title,$3,g" "$1/index.html" > "$1/tmp.html"
fi

mv "$1/tmp.html" "$1/index.html"
