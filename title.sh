#!/usr/bin/env bash

# This script dynamically helps pick a title for a new shortlink by scanning the web for an existing title and then asking for permission to use what it found (or allow the user to supply an alternative)

title=
dir="$1"
link="$2"

localTitle="$(awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}' "$dir/index.html")"

if [[ "$localTitle" == "Redirecting to"* ]] || [ "$localTitle" == "redirect-title" ] || [ -z "$localTitle" ]; then
	webTitle="$(wget --timeout=5 -qO- "$link" | awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}')"
	# Trim whitespace and limit to one line to tame crazy pages (looking at you, RedBubble)
	webTitle=$(echo "$webTitle" | awk '{$1=$1};1' | sed -n '1,1 p')

	useWebTitle=
	if [ -z "$webTitle" ]
	then
		useWebTitle="n"
	else
		read -rp "Do you want to use \"$webTitle\" as the title for \"$link\"? [Y/n] " -e useWebTitle </dev/tty
		# Default value
		useWebTitle=${useWebTitle:-Y}
		# Trim whitespace
		useWebTitle=$(echo "$useWebTitle" | awk '{$1=$1};1')
	fi

	if [[ "$useWebTitle" == "Y" ]]; then
		title="$webTitle"
	else
		while [ -z "$title" ]; do
			read -rp "What title do you want to use for \"$link\"? " -e title </dev/tty
			# Trim whitespace
			title=$(echo "$title" | awk '{$1=$1};1')
		done
	fi
else
	title="$localTitle"
fi

echo "$title"
