#!/usr/bin/env bash

# This script is a wrapper around title.sh that loops through all files in the repo and allows me to quickly update ones with a non-pretty HTML title
# Likely not needed now that I've cleaned up all my links, but I'm leaving it here for potential usefulness in the future

while IFS= read -r -d '' dir
do
	# Only work with real files, not symlinks
	if [ -f "$dir/index.html" ] && [ ! -L "$dir/index.html" ]; then
		link="$(grep "window.location.href" "$dir/index.html" | sed -e 's/\s*window\.location\.href = "//g' | rev | cut -c3- | rev)"
		title="$(./title.sh "$dir" "$link")"
		./generate.sh "$dir" "$link" "$title"
	fi
done < <( find . -type d -not -path '*/.git*' -print0)

