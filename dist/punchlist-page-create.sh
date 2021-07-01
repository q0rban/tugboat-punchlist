#!/usr/bin/env bash
set -eo pipefail

outfile="/root/punchlist-page.json"
touch $outfile

if [[ -z "$PUNCHLIST_TOKEN" ]]; then
	echo \
"You must generate a punchlist token and add a custom environment to your
Tugboat Repository settings called PUNCHLIST_TOKEN with this token." 1>&2;
	exit 23
fi

if [[ -z "$PUNCHLIST_PROJECT" ]]; then
	echo \
"You must create a punchlist project and add a custom environment to your
Tugboat Repository settings called PUNCHLIST_PROJECT with the project ID." 1>&2;
	exit 23
fi

pages=$(curl --silent \
	-H "Authorization: Bearer $PUNCHLIST_TOKEN" \
	-H "Content-Type: application/json" \
	-H "Accept: application/json" \
	https://app.punchli.st/api/v1/projects/$PUNCHLIST_PROJECT/pages |
	jq '.data.pages[] | select( .url == "'${TUGBOAT_SERVICE_URL}'")' || true)

if [[ -n "$pages" ]]; then
	echo "Using previously created page on punchlist:" 1>&2;
	echo "$pages" | tee $outfile
else
	echo "Creating a new page on punchlist:" 1>&2;
	payload=$(printf '{
		"title": "Tugboat Preview: %s (%s)",
		"url": "%s",
		"default": false
	}' $TUGBOAT_PREVIEW_NAME $TUGBOAT_PREVIEW_REF $TUGBOAT_SERVICE_URL)

	curl --silent \
		-H "Authorization: Bearer $PUNCHLIST_TOKEN" \
		-H "Content-Type: application/json" \
		-H "Accept: application/json" \
		-d "$payload" \
		https://app.punchli.st/api/v1/projects/$PUNCHLIST_PROJECT/pages \
		| jq '.' | tee $outfile
fi
