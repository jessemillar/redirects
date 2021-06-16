#!/usr/bin/env bash

while IFS= read -r -d '' dir
do
	if [ -f "$dir/index.html" ]; then
		# TODO Parse out the page title too
		link="$(grep "window.location.href" "$dir/index.html" | sed -e 's/\s*window\.location\.href = "//g' | rev | cut -c3- | rev)"
		./generate.sh "$dir" "$link"
	fi
done < <( find . -type d -not -path '*/.git*' -print0)

