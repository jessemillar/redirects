#!/usr/bin/env bash

while IFS= read -r -d '' dir
do
	title=

	# Only work with real files, not symlinks
	if [ -f "$dir/index.html" ] && [ ! -L "$dir/index.html" ]; then
		link="$(grep "window.location.href" "$dir/index.html" | sed -e 's/\s*window\.location\.href = "//g' | rev | cut -c3- | rev)"
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

		./generate.sh "$dir" "$link" "$title"
	fi
done < <( find . -type d -not -path '*/.git*' -print0)

