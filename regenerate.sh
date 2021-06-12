#!/usr/bin/env bash

while IFS= read -r -d '' dir
do
	if [ -f "$dir/index.html" ]; then
		link="$(grep "Redirecting to" "$dir/index.html" | sed -e 's/<title>Redirecting to //g' | sed -e 's/<\/title>//g')"
		./generate.sh "$dir" "$link"
	fi
done < <( find . -type d -not -path '*/.git*' -print0)

