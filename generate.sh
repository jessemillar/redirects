#!/usr/bin/env bash

mkdir -p "$1" || true
sed "s,redirect-link,${2//&/\\&},g" template.html > "$1/index.html"

pageTitle="$(wget -qO- "$2" | awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}')"
if [ -z "$pageTitle" ]
then
	# Use the link as the page title
	sed "s,redirect-title,Redirecting to ${pageTitle//&/\\&},g" template.html > "$1/index.html"
else
	# Use the dynamic page title
	sed "s,redirect-title,${pageTitle//&/\\&},g" template.html > "$1/index.html"
fi
