#!/usr/bin/env bash

while IFS= read -r -d '' dir
do
	# Only work with real files, not symlinks
	if [ -f "$dir/index.html" ] && [ ! -L "$dir/index.html" ]; then
		link="$(grep "window.location.href" "$dir/index.html" | sed -e 's/\s*window\.location\.href = "//g' | rev | cut -c3- | rev)"
		localTitle="$(awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}' "$dir/index.html")"

		if [[ "$localTitle" != "*Redirecting to*" ]]; then
			webTitle="$(curl -L "$link" | awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}')"

			read -rp "Do you want to use $webTitle as the redirect title? [Y/n] " -e useWebTitle
			# Default value
			useWebTitle=${useWebTitle:-Y}
			# Trim whitespace
			useWebTitle=$(echo "$useWebTitle" | awk '{$1=$1};1')

			if [[ "$useWebTitle" == "Y" ]]; then
				title="$webTitle"
			else
				while [ -z "$title" ]; do
					read -rp "What title do you want to use? " -e title
					# Trim whitespace
					title=$(echo "$title" | awk '{$1=$1};1')
				done
			fi
		fi

		./generate.sh "$dir" "$link" "$title"
	fi
done < <( find . -type d -not -path '*/.git*' -print0)

