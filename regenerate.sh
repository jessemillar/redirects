#!/usr/bin/env bash

while IFS= read -r -d '' dir
do
	if [ -f "$dir/index.html" ]; then
		# TODO Parse out the page title too
		link="$(grep "window.location.href" "$dir/index.html" | sed -e 's/\s*window\.location\.href = "//g' | rev | cut -c3- | rev)"
		title="$(awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}' "$dir/index.html")"
		echo "$title"
		#./generate.sh "$dir" "$link" "$title"
	fi
done < <( find . -type d -not -path '*/.git*' -print0)

