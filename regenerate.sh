#!/usr/bin/env bash

while IFS= read -r -d '' dir
do
	./generate.sh "$dir" "$(grep "Redirecting to" "$dir/index.html" | sed -e 's/<title>Redirecting to //g' | sed -e 's/<\/title>//g')"
done < <( find . -type d -not -path '*/.git*' -print0)

