#!/bin/bash

set -euo pipefail

CURRENT_VERSION=$(git describe --tags --abbrev=0 2>/dev/null)

if [[ -z $CURRENT_VERSION ]]; then
	echo "Error! Failed to get curren version"
	exit 1
fi

LATEST_RELEASE="$(gh api repos/:owner/:repo/releases/latest --jq '.tag_name')"

if [[ -z $LATEST_RELEASE ]]; then
	echo "Error! Failed to get latest tag from GitHub!"
	exit 1
fi

if [[ $CURRENT_VERSION == "$LATEST_RELEASE" ]]; then
	echo "All Good! No need to create a new release"
else
	echo "Current Version: $CURRENT_VERSION"
	echo "Latest Release : $LATEST_RELEASE"

	if [[ ! -e build/release-notes.md ]]; then
		echo "Create: Release Notes"
		make release-notes
	else
		echo "Using existing release notes"
	fi

	if [[ ! -e build/release-notes.md ]]; then
		echo "Create: Checksums"
		make checksums
	else
		echo "Using existing checksums notes"
	fi

	echo "Create: GH-Release"
	gh release create \
		--notes-file build/release-notes.md \
		--title "$CURRENT_VERSION" \
		"$CURRENT_VERSION" \
		build/Cascadia/*.ttf \
		build/Fantasque/*.ttf \
		build/SHA256SUMS.txt
fi
