#!/usr/bin/env bash

title=
dir="$1"
link="$2"

localTitle="$(awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}' "$dir/index.html")"

if [[ "$localTitle" == "Redirecting to"* ]]; then
	webTitle="$(wget -qO- "$link" | awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}')"
	# Trim whitespace
	webTitle=$(echo "$webTitle" | awk '{$1=$1};1' | awk 'NF')

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
